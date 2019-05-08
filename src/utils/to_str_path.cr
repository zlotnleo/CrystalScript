class CrystalScript
  def self.to_str_path(named_type : NamedType)
    named_type.full_name.split("::")
  end

  def self.to_str_path(generic_instance_type : GenericInstanceType)
    names = self.to_str_path(generic_instance_type.generic_type)
    names[-1] += "(" + generic_instance_type.type_vars.values.map(&.type?).join(",") + ")"
    return names
  end

  def self.to_str_path(path : Path)
    path.names
  end

  def self.to_str_path(_nil : Nil)
    nil
  end

  def self.to_str_path(type : Type)
    raise "Cannot get name of Type that isn't NamedType or GenericInstanceType"
  end
end
