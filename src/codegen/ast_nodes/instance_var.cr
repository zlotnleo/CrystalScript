class CrystalScript::CodeGen
  private def generate(node : InstanceVar)
    "this." + node.name[1..-1]
  end
end
