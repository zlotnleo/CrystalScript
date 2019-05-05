class CrystalScript
  def init_named_types
    String.build do |str|
      @nto.in_subclass_namespace_order do |named_type|
        case named_type
        when FileModule
          # TODO. This case is used to avoid handling FileModule as other NamedType's
        # when NonGenericModuleType, NonGenericClassType, MetaclassType, PrimitiveType
        when NamedType
          # TODO: handle if named_type.is_a? GenericType (and maybe GenericInstanceType)
          js_name = CrystalScript.to_js_name(named_type)
          if named_type.full_name == "Object"
            model = {
              "TypeName" => js_name,
              "DisplayName" => named_type.full_name
            }
            str << Crustache.render Templates::OBJECT_TYPE_DECLARATION, model
          else
            js_superclass = CrystalScript.to_js_name named_type.superclass
            model = {
              "TypeName" => js_name,
              "DisplayName" => named_type.full_name,
              "has_superclass" => js_superclass.nil? ? false : {"SuperClass" => js_superclass}
            }
            str << Crustache.render Templates::TYPE_DECLARATION, model
          end
          str << Crustache.render Templates::HAS_INSTANCE, {"TypeName" => js_name}

        else
          # TODO!
          # str << "const Crystal_Program." << named_type.to_s.gsub("::", ".")
          str << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
