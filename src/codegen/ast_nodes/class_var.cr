class CrystalScript::CodeGen
  private def generate(node : ClassVar)
    # TODO get the class
    "class_name.#{node.name}"
  end
end
