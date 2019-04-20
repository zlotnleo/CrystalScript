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

          model = Hash(String, String | Hash(String, String) | Array(Hash(String, String))) {
            "TypeName" => js_name
          }
          model["is_object"] = [{} of String => String] if named_type.full_name == "Object"
          model["has_superclass"] = {"SuperClass" => js_superclass} unless js_superclass.nil?
          model["included_modules"] = [] of Hash(String, String)
          included_modules.each do |mod|
            mod_js_name = CodeGen.to_js_name(mod)
            model["included_modules"].as(Array) << {"Module" => mod_js_name} unless mod_js_name.nil?
          end

          str << Crustache.render CodeGen::Templates::TYPE_DECLARATION, model
        else
          # TODO?
          str << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
