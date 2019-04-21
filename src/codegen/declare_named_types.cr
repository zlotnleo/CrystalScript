class CrystalScript::CodeGen
  def declare_named_types
    String.build do |str|
      @ntv.in_namespace_order do |named_type|
        case named_type
        when FileModule
          # TODO. This case is used to avoid handling FileModule as other NamedType's
        # when NonGenericModuleType, NonGenericClassType, MetaclassType, PrimitiveType
        when NamedType
          # TODO: handle if named_type.is_a? GenericType (and maybe GenericInstanceType)
          js_name = CodeGen.to_js_name(named_type)
          if js_name.nil?
            CrystalScript.logger.error("Found named type with no name: #{named_type}")
            break
          end
          js_superclass = CodeGen.to_js_name(named_type.superclass)
          included_modules = named_type.parents.dup
          included_modules = [] of Crystal::Type if included_modules.nil?
          included_modules.delete(named_type.superclass)

          model = {
            "TypeName" => js_name,
            "is_object" => named_type.full_name == "Object",
            "has_superclass" => js_superclass.nil? ? false : {"SuperClass" => js_superclass},
            "included_modules" => included_modules.map do |mod|
              CodeGen.to_js_name mod
            end.select do |mod_name|
              !mod_name.nil?
            end.map do |mod_name|
              {"Module" => mod_name}
            end
          }

          str << Crustache.render Templates::TYPE_DECLARATION, model
        else
          # TODO?
          str << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
