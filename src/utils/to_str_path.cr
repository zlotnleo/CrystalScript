class CrystalScript
  def self.to_str_path(metaclass_type : MetaclassType | VirtualMetaclassType | GenericModuleInstanceMetaclassType | GenericClassInstanceMetaclassType)
    [(self.to_str_path metaclass_type.instance_type).join("::") + ".class"]
  end

  def self.to_str_path(union_type : UnionType)
    ["(" + union_type.union_types.map { |sub_t| (self.to_str_path sub_t).join("::") }.join("|") + ")"]
  end

  def self.to_str_path(virtual_type : VirtualType)
    names = self.to_str_path(virtual_type.base_type)
    names[-1] += "+"
    names
  end

  def self.to_str_path(named_type : NamedType)
    named_type.full_name.split("::")
  end

  def self.to_str_path(generic_instance_type : GenericInstanceType)
    names = self.to_str_path(generic_instance_type.generic_type)

    names[-1] += "(" + generic_instance_type.type_vars.values.map do |node|
      if node.is_a? Var
        if (t = node.type?).is_a? TupleInstanceType
          t.tuple_types.map { |sub_t| (self.to_str_path sub_t).join("::") }.join(",")
        elsif t.is_a? NamedTupleInstanceType
          t.entries.map { |entry| entry.name + ": " + (self.to_str_path entry.type).join("::") }.join(",")
        else
          self.to_str_path(t).try &.join("::")
        end
        # get_generic_argument_name(node.type?)
      else
        node.to_s
      end
    end.join(",") + ")"
    return names
  end

  def self.to_str_path(path : Path)
    path.names
  end

  def self.to_str_path(_nil : Nil)
    nil
  end

  def self.to_str_path(type : Type)
    CrystalScript.logger.error "Trying to get type of #{type} : #{type.class}"
    raise "Error: Trying to get string path of unsupported type"
  end
end
