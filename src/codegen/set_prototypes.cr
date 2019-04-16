class CrystalScript::CodeGen
  def set_named_types_prototypes
    String.build do |str|
      @ntv.in_subclass_mixin_order do |named_type|
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

          # Set name
          str << "Object.defineProperty(" << js_name << ".prototype.constructor, 'name', {value: '" << named_type.full_name << "'});\n"

          # Set superclass and add mixin methods
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

          # Set list of included modules
          str << js_name << ".prototype.$included_modules = "
          if js_superclass.nil?
            str << "[]"
          else
            str << js_superclass << ".prototype.$included_modules"
          end
          unless included_modules.empty?
            str << ".concat(["
            included_modules[0...-1].each do |mod|
              str << CodeGen.to_js_name(mod) << ", "
            end
            str << CodeGen.to_js_name(included_modules[-1]) << "])"
          end
          str << ";\n"

          # Assign constructor function
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
