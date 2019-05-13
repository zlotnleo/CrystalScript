class CrystalScript
  def init_named_types
    String.build do |str|
      @nto.in_subclass_namespace_order do |named_type|
        if named_type.is_a? NamedType || named_type.is_a? GenericInstanceType
          names = CrystalScript.to_str_path(named_type)
          path = names.map { |name| {"Type" => name} }
          if names == ["Object"]
            str << Crustache.render Templates::OBJECT_TYPE_DECLARATION, nil
          else
            superclass = named_type.superclass
            if named_type.is_a? GenericType && superclass.is_a? GenericInstanceType
              superclass = superclass.generic_type
            end

            superclass_names = superclass.try { |sup| CrystalScript.to_str_path sup }
            model = {
              "path" => path,
              "DisplayName" => names.join("::"),
              "has_superclass" => superclass_names.nil? ? false : {
                "super_path" => superclass_names.map { |name| {"Type" => name} }
              }
            }
            str << Crustache.render Templates::TYPE_DECLARATION, model
          end
        else
          # TODO!
          str << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
