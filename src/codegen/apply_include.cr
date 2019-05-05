class CrystalScript
  def apply_include
    String.build do |str|
      @nto.in_mixin_order do |named_type|
        case named_type
        when FileModule
          # TODO. This case is used to avoid handling FileModule as other NamedType's
        # when NonGenericModuleType, NonGenericClassType, MetaclassType, PrimitiveType
        when NamedType
          # TODO: handle if named_type.is_a? GenericType (and maybe GenericInstanceType)

          included_modules = named_type.parents.try &.select { |parent| parent.module? }
          unless included_modules.nil? || included_modules.empty?
            model = {
              "TypeName" => CrystalScript.to_js_name(named_type),
              "included_modules" => included_modules.map do |mod|
                {"Module" => CrystalScript.to_js_name mod}
              end
            }
            str << Crustache.render Templates::APPLY_INCLUDE, model
          end

          # Define instance methods on the type
          str << define_instance_methods(named_type)
        else
          # TODO!
          # str << "const Crystal_Program." << named_type.to_s.gsub("::", ".")
          str << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
