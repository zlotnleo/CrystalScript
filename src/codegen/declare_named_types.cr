class CrystalScript::CodeGen
  def declare_named_types
    String.build do |str|
      @ntv.traverse_tree do |named_type|
        case named_type
        when FileModule
          # TODO. This case is used to avoid handling FileModule as other NamedType's
        # when NonGenericModuleType, NonGenericClassType, MetaclassType, PrimitiveType
        when NamedType
          # TODO: handle if named_type.is_a? GenericType (and maybe GenericInstanceType)
          js_name = CodeGen.to_js_name(named_type)
          js_superclass = CodeGen.to_js_name(named_type.superclass)
          included_modules = named_type.parents.dup
          included_modules = [] of Crystal::Type if included_modules.nil?
          included_modules.delete(named_type.superclass)

          str << js_name << " = function() {\n"
          if named_type.full_name == "Object"
            str << "  this.$class_vars = Object.create(null);\n"
          end
          unless js_superclass.nil?
            str << "  " << js_superclass << ".call(this);\n"
          end
          included_modules.each do |mod|
            str << "  " << CodeGen.to_js_name(mod) << ".call(this);\n"
          end
          str << "};\n"
        else
          # TODO!
          # str << "const Crystal_Program." << named_type.to_s.gsub("::", ".")
          str << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
