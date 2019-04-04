class CrystalScript::CodeGen
  def set_named_types_prototypes
    String.build do |str|
      @ntv.traverse_tree do |named_type|
        case named_type
        # when NonGenericModuleType, NonGenericClassType, MetaclassType, PrimitiveType
        when NamedType
          # TODO: handle if named_type.is_a? GenericType (and maybe GenericInstanceType)
          js_name = CodeGen.to_js_name(named_type)
          js_superclass = CodeGen.to_js_name(named_type.superclass)
          included_modules = named_type.parents.dup
          included_modules = [] of Crystal::Type if included_modules.nil?
          included_modules.delete(named_type.superclass)

          str << "set_custom_class_name(" << js_name << ", '" << named_type.full_name << "');\n"

          str << js_name << ".prototype = Object.assign("
          str << "Object.create("
          if js_superclass.nil?
            str << "null"
          else
            str << js_superclass + ".prototype"
          end
          str << ")"
          included_modules.each do |mod|
            str  << ", " << CodeGen.to_js_name(mod) << ".prototype"
          end
          str << ");\n"

          str << js_name << ".prototype.constructor = " << js_name << ";\n"
        else
          # TODO!
          # str << "const Crystal_Program." << named_type.to_s.gsub("::", ".")
          str << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
