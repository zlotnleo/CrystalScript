class CrystalScript
  def self.get_method(type : Type?, a_def : Def, *, is_instance)
    type = type.instance_type unless is_instance || type.nil?
    Crustache.render Templates::METHOD, {
      "class" => if !type.nil?
        {
          "instance_method" => is_instance,
          "path" => CrystalScript.to_str_path(type).map { |t| {"Type" => t} }
        }
        else
         false
        end,
      "MethodName" => a_def.name,
      "arg_types" => a_def.args.map { |arg| {
          "Type" => CrystalScript.to_str_path(arg.type?).try &.join("::")
      } }
    }
  end
end
