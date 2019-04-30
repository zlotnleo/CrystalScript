class CrystalScript
  def init_named_types
    String.build do |str|
      @ntv.in_subclass_namespace_order do |named_type|
        case named_type
        when FileModule
          # TODO. This case is used to avoid handling FileModule as other NamedType's
        # when NonGenericModuleType, NonGenericClassType, MetaclassType, PrimitiveType
        when NamedType
          # TODO: handle if named_type.is_a? GenericType (and maybe GenericInstanceType)
          js_name = CrystalScript.to_js_name(named_type)
          js_superclass = CrystalScript.to_js_name named_type.superclass
          included_modules = named_type.parents.dup
          included_modules = [] of Type if included_modules.nil?
          included_modules.delete(named_type.superclass)

          model = {
            "TypeName" => js_name,
            "DisplayName" => named_type.full_name,
            "is_object" => named_type.full_name == "Object",
            "has_superclass" => js_superclass.nil? ? false : {"SuperClass" => js_superclass}
          }

          str << Crustache.render Templates::TYPE_DECLARATION, model

          # Define methods on the type
          str << define_methods(named_type)
        else
          # TODO!
          # str << "const Crystal_Program." << named_type.to_s.gsub("::", ".")
          str << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
