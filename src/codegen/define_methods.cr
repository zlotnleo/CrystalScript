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
              "MethodName" => CrystalScript.get_method(a_def, include_args: false, include_class: true, is_instance: instance)
            }
          end
          CrystalScript.logger.info a_def
          @output << Crustache.render Templates::DEFINE_METHOD, {
            "MethodName" => CrystalScript.get_method(a_def, include_args: true, include_class: true, is_instance: instance),
            "Body" => ExpressionGen.new.generate(a_def.body)
          }
        end
      end
    end
  end
end
