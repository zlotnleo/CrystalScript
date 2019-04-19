class CrystalScript::CodeGen
  def define_methods(named_type)
    String.build do |str|
      unless (defs = named_type.defs).nil?
        defs.each do |method_name, method_defs|
          str << CodeGen.to_js_name(named_type) << ".prototype"
          str << "['" << method_name << "']" << " = new "
          str << CrystalScript.method_class << "(["
          method_defs.each do |method_def|
            str << "{\n"
            str << "  func: function (args) {\n"
            # TODO body generation
            str << "  },\n"
            str << "  min_args: " << method_def.min_size << ",\n"
            str << "  max_args: " << method_def.max_size << ",\n"
            str << "  has_block: " << (method_def.yields ? "true" : "false") << ",\n"
            str << "}, "
          end
          str << "]);\n"
        end
      end
    end
  end
end
