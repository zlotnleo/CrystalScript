class CrystalScript::CodeGen
  def define_methods(named_type : NamedType)
    type_name = CodeGen.to_js_name(named_type)
    String.build do |str|
      if named_type.is_a? ClassType
        str << Crustache.render Templates::CLASS_NEW, {
          "TypeName" => type_name,
          "has_init" => !(defs = named_type.defs).nil? && defs.has_key? "initialize"
        }
      end
      unless (defs = named_type.metaclass.defs).nil?
        defs.delete("allocate")
        defs.delete("new")
        define_methods str, type_name, defs, instance: false
      end
      unless (defs = named_type.defs).nil?
        define_methods str, type_name, defs, instance: true
      end
    end
  end

  private def define_methods(str, name, defs, *, instance)
    defs.each do |method_name, method_defs|
      model = {
        "GlobalClass" => CrystalScript::GLOBAL_CLASS,
        "MethodClass" => CrystalScript::METHOD_CLASS,
        "is_instance" => instance,
        "TypeName" => name,
        "MethodName" => method_name,
        "funcs" => method_defs.map do |method_def|
          {
            "MinArgs" => method_def.min_size.to_s,
            "MaxArgs" => method_def.max_size.to_s,
            "HasBlock" => method_def.yields ? "true" : "false",
            "MethodBody" => "/* #{method_def.def.body} */",
            "func_args" => method_def.def.args.select do |arg|
              !arg.name.empty?
            end.map do |arg|
              {
                "ArgName" => CodeGen.safe_var_name(arg.name),
                "has_default" => begin
                  if (default = arg.default_value).nil?
                    false
                  else
                    {
                      "DefaultVal" => generate(default)
                    }
                  end
                end
              }
            end,
            "has_external_names" => begin
              different_name_args = method_def.def.args.select do |arg|
                arg.external_name != arg.name
              end
              if different_name_args.empty?
                false
              else
                {
                  "external_names" => different_name_args.map do |arg|
                    {
                      "ExternalName" => arg.external_name,
                      "InternalName" => arg.name
                    }
                  end
                }
              end
            end
          }
        end
      }

      str << Crustache.render Templates::DEFINE_METHODS, model
    end
  end
end
