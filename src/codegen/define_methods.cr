class CrystalScript
  def define_instance_methods(type)
    define_methods(type, instance: true)
  end

  def define_class_methods(type)
    define_methods(type, instance: false)
  end

  def define_methods(named_type, *, instance)
    named_type = named_type.metaclass unless instance
    if named_type.is_a? DefInstanceContainer
      named_type.def_instances.values.each do |a_def|
        unless a_def.body.is_a? Primitive
          @output << Crustache.render Templates::DEFINE_METHOD, {
            "MethodName" => CrystalScript.get_method(named_type, a_def, is_instance: instance),
            "args" => a_def.args.map { |arg|
              { "Arg" => arg.name }
            },
            "Body" => ExpressionGen.new.generate(a_def)
          }
        end
      end
    end
  end
end
