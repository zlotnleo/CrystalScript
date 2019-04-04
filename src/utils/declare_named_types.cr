class CrystalScript::CodeGen
  def declare_named_types
    String.build do |str|
      @ntv.traverse_tree do |named_type|
        case named_type
        when NonGenericModuleType, NonGenericClassType, MetaclassType, PrimitiveType
          js_name = CodeGen.to_js_name(named_type)
          puts js_name
          js_superclass = CodeGen.to_js_name(named_type.superclass)
          included_modules = named_type.parents.dup
          included_modules = [] of Crystal::Type if included_modules.nil?
          included_modules.delete(named_type.superclass)

          str << js_name << <<-DEF
           = function() {
            init_class_vars();\n
          DEF
          unless js_superclass.nil?
            str << "  #{js_superclass}.call(this);\n"
          end
          included_modules.each do |mod|
            str << "  #{CodeGen.to_js_name(mod)}.call(this);\n"
          end
          str << <<-DEF
          };
          set_custom_class_name(#{js_name}, '#{named_type.full_name}');
          #{js_name}.prototype = Object.assign(
          DEF
          str << "Object.create(#{js_superclass.nil? ? "null" : js_superclass + ".prototype"})"

          included_modules.each do |mod|
            str  << ", " << CodeGen.to_js_name(mod) << ".prototype"
          end

          str << <<-DEF
          );
          #{js_name}.prototype.constructor = #{js_name};

          DEF
        else
          # TODO!
          # str << "const Crystal_Program." << named_type.to_s.gsub("::", ".")
          str << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
