class CrystalScript
  def init_named_types
    @nto.in_subclass_namespace_order do |named_type|
      if named_type.is_a? NamedType || named_type.is_a? GenericInstanceType
        names = CrystalScript.to_str_path(named_type)
        path = names.map { |name| {"Type" => name} }
        if names == ["Object"]
          @output << Crustache.render Templates::OBJECT_TYPE_DECLARATION, nil
        else
          superclass = named_type.superclass
          if named_type.is_a? GenericType && superclass.is_a? GenericInstanceType
            superclass = superclass.generic_type
          end
          superclass_names = superclass.try { |sup| CrystalScript.to_str_path sup }
          @output << Crustache.render Templates::TYPE_DECLARATION, {
            "path" => path,
            "DisplayName" => names.join("::"),
            "has_superclass" => superclass_names.nil? ? false : {
              "super_path" => superclass_names.map { |name| {"Type" => name} }
            },
            "instance_var_init" => if named_type.is_a? InstanceVarInitializerContainer && named_type.is_a? InstanceVarContainer
              Crustache.render Templates::INSTANCE_VAR_INIT, {
                "instance_vars" => named_type.instance_vars.keys.map { |name|
                  if named_type.has_instance_var_initializer? name
                    var = named_type.get_instance_var_initializer(name).not_nil!
                    {
                      "Name" => name,
                      "Value" => ExpressionGen.new.generate(var.value)
                    }
                  else
                    {
                      "Name" => name,
                      "Value" => "#{CrystalScript::GLOBAL_CLASS}.nil"
                    }
                  end
                }
              }
            else
              nil
            end
          }
          if named_type.is_a? ClassVarContainer
            @output << Crustache.render Templates::CLASS_VARS, {
              "path" => path,
              "initialisers" => named_type.class_vars.values.reject(&.initializer.nil?).map { |var|
                initializer = var.initializer.not_nil!
                {
                  "Name" => initializer.name,
                  "Value" => ExpressionGen.new.generate initializer.node
                }
              }
            }
          end
        end
      else
        # TODO!
        @output << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
      end
    end
  end
end
