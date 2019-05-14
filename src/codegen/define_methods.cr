class CrystalScript
  def define_instance_methods
    define_methods(instance: true)
  end

  def define_class_methods
    define_methods(instance: false)
  end

  def define_methods(*, instance)
    @nto.in_any_order do |named_type|
      named_type = named_type.metaclass unless instance
      if named_type.is_a? DefInstanceContainer
        initialised_def_names = Set(String).new
        named_type.def_instances.values.each do |a_def|
          if initialised_def_names.add? a_def.name
            @output << Crustache.render Templates::INIT_METHOD, {
              "MethodName" => CrystalScript.get_method(named_type, a_def, include_args: false, is_instance: instance)
            }
          end

          if instance || a_def.name != "allocate"
            @output << Crustache.render Templates::DEFINE_METHOD, {
              "MethodName" => CrystalScript.get_method(named_type, a_def, include_args: true, is_instance: instance),
              "Body" => ExpressionGen.new.generate(a_def.body)
            }
          else
            @output << Crustache.render Templates::ALLOCATE, {
              "path" => CrystalScript.to_str_path(named_type.instance_type).try &.map { |t|
                { "Type" => t }
              }
            }
          end
        end
      end
    end
  end
end
