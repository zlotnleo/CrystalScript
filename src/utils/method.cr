class CrystalScript
  def self.get_method(a_def : Def, *, include_args, include_class, is_instance)
    klass = is_instance ? a_def.owner : a_def.owner.instance_type
    Crustache.render Templates::METHOD, {
      "class" => if include_class
        {
          "instance_method" => is_instance,
          "path" => CrystalScript.to_str_path(klass).map { |t| {"Type" => t} }
        }
        else
         false
        end,
      "MethodName" => a_def.name,
      "include_args" => if include_args
        {
          "arg_types" => a_def.args.map { |arg|
            {
              "Type" => CrystalScript.to_str_path(arg.type?).try &.join("::")
            }
          }
        }
        else
          false
        end
    }
  end
end
