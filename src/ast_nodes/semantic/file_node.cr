module CrystalScript
  class CodeGen
    def generate(node : FileNode)
      return generate(node.node)
    end
  end
end
