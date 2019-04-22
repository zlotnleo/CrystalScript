class CrystalScript::CodeGen
  def define_methods(named_type : NamedType)
    type_name = CodeGen.to_js_name(named_type)
    String.build do |str|
      if named_type.is_a? ClassType
        str << Crustache.render Templates::CLASS_NEW, {"TypeName" => type_name}
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

  private def set_local_vars_from_arguments(method_def, param_name)
    String.build do |str|
      # TODO: fix clash with JS keywords
      # TODO: fix empty named args
      args = method_def.args
      unless args.empty?
        str << "let {"
        method_def.args.each do |arg|
          str << arg.name << ","
          if arg.name.empty?
            CrystalScript.logger.debug("Argument without name in method #{method_def}")
          end
        end
        str << "} = Object.assign({"
        method_def.args.each do |arg|
          unless (default = arg.default_value).nil?
            str << "'" << arg.name << "': " << generate(default) << ","
          end
        end
        str << "}, " << param_name << ");"
      end
    end



    # named_args = method_def.def.args.select { |arg| !arg.default_value.nil? }
    # CrystalScript.logger.warn("In #{method_def.def.owner}.#{method_def.def.name}: #{named_args}") unless named_args.empty?

    # String.build do |str|
    #   # str << "let {"
    # end
  end
end
