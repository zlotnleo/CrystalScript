class CrystalScript::CodeGen
  def define_methods(named_type)
    js_type_name = CodeGen.to_js_name(named_type)
    if js_type_name.nil?
      CrystalScript.logger.error("Found named type with no name: #{named_type}")
      return "/* BUG: named type with no name: #{named_type} */"
    end

    String.build do |str|
      unless (defs = named_type.defs).nil?
        defs.each do |method_name, method_defs|
          model = Hash(String, String | Hash(String, String) | Array(Hash(String, String)) | Bool) {
            "GlobalClass" => CrystalScript::GLOBAL_CLASS,
            "MethodClass" => CrystalScript::METHOD_CLASS,
            "TypeName" => js_type_name,
            "MethodName" => method_name
          }
          model["funcs"] = method_defs.map do |method_def|
            {
              "MinArgs" => method_def.min_size.to_s,
              "MaxArgs" => method_def.max_size.to_s,
              "HasBlock" => method_def.yields ? "true" : "false",
            }
          end

          str << Crustache.render CodeGen::Templates::DEFINE_METHODS, model
        end

        # defs.each do |method_name, method_defs|
        #   str << CodeGen.to_js_name(named_type) << ".prototype"
        #   str << "['" << method_name << "']" << " = new "
        #   str << CrystalScript::GLOBAL_CLASS << "." << CrystalScript::METHOD_CLASS << "(["
        #   method_defs.each do |method_def|
        #     str << "{\n"
        #     str << "  func: function (args) {\n"
        #     str << "    " << set_local_vars_from_arguments(method_def.def, "args") << "\n"
        #     # TODO body generation
        #     str << "  },\n"
        #     str << "  min_args: " << method_def.min_size << ",\n"
        #     str << "  max_args: " << method_def.max_size << ",\n"
        #     str << "  has_block: " << (method_def.yields ? "true" : "false") << ",\n"
        #     str << "}, "
        #   end
        #   str << "]);\n"
        # end
      end
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
