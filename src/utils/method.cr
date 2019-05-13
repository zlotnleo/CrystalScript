class CrystalScript
  def self.get_method(a_def : Def, *, include_args, include_class)
    Crustache.render Templates::METHOD, {
      "class" => if include_class
        {
          "path" => CrystalScript.to_str_path(a_def.owner).map { |t| {"Type" => t} }
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
