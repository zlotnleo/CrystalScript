class CrystalScript
  # def self.get_generic_argument_name(union_type : Nil)
  #   nil
  # end

  # def self.get_generic_argument_name(union_type : UnionType)
  #   union_type.union_types.map { |sub_t| (self.to_str_path sub_t).join("::") }.join("|")
  # end

  # # Has to be handled separately since tuple's #type_vars is a single TupleInstanceType
  # def self.get_generic_argument_name(tuple_type : TupleInstanceType)
  #   result = tuple_type.tuple_types.map { |sub_t| (self.to_str_path sub_t).join("::") }.join(",")
  #   CrystalScript.logger.info("#{tuple_type}: #{result}")
  #   return result
  # end

  # def self.get_generic_argument_name(named_tuple_type : NamedTupleInstanceType)
  #   named_tuple_type.entries.map { |entry| entry.name + ": " + (self.to_str_path entry.type).join("::") }.join(",")
  # end

  # def self.get_generic_argument_name(virtual_type : VirtualType)
  #   (self.get_generic_argument_name virtual_type.base_type) + "+"
  # end

  # def self.get_generic_argument_name(type : Type)
  #   self.to_str_path(type).join("::")
  # end

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
    CrystalScript.logger.info generic_instance_type
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
