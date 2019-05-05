class CrystalScript
  def apply_extend
    String.build do |str|
      @nto.in_any_order do |named_type|
        case named_type
        when FileModule
          # TODO. This case is used to avoid handling FileModule as other NamedType's
        # when NonGenericModuleType, NonGenericClassType, MetaclassType, PrimitiveType
        when NamedType
          # TODO: handle if named_type.is_a? GenericType (and maybe GenericInstanceType)

          extended_modules = named_type.metaclass.parents.try &.select { |parent| parent.module? }
          unless extended_modules.nil? || extended_modules.empty?
            model = {
              "TypeName" => CrystalScript.to_js_name(named_type),
              "extended_modules" => extended_modules.map do |mod|
                {"Module" => CrystalScript.to_js_name mod}
              end
            }
            str << Crustache.render Templates::APPLY_EXTEND, model
          end

          # Define class methods on the type
          str << define_class_methods(named_type)
        else
          # TODO!
          # str << "const Crystal_Program." << named_type.to_s.gsub("::", ".")
          str << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
