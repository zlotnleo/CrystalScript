class CrystalScript::CodeGen
  def define_methods(named_type)
    String.build do |str|
      unless (defs = named_type.defs).nil?
        defs.each do |method_name, method_defs|
          str << CodeGen.to_js_name(named_type) << ".prototype"
          str << "['" << method_name << "']" << " = new "
          str << CrystalScript.method_class << "(["
          method_defs.each do |method_def|
            # TODO
          end
          str << "]);\n"
        end
      end
    end
  end
end
