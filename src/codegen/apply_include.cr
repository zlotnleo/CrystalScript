class CrystalScript
  def apply_include
    String.build do |str|
      @nto.in_mixin_order do |named_type|
        if named_type.is_a? NamedType || named_type.is_a? GenericInstanceType
          included_modules = named_type.parents.try &.select { |parent| parent.module? }
          unless included_modules.nil? || included_modules.empty?
            if named_type.is_a? GenericType
              included_modules.map! do |included_module|
                if included_module.is_a? GenericInstanceType
                  included_module.generic_type.as(Type)
                else
                  included_module
                end
              end
            end
            model = {
              "path" => CrystalScript.to_str_path(named_type).map { |name| {"Type" => name} },
              "included_modules" => included_modules.map do |mod|
                {"path" => CrystalScript.to_str_path(mod).map { |name| {"Type" => name} }}
              end
            }
            str << Crustache.render Templates::APPLY_INCLUDE, model
          end

          # Define instance methods on the type
          # str << define_instance_methods(named_type)
        else
          # TODO!
          str << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
