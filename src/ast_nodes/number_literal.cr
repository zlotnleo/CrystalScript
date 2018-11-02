module CrystalScript
  class AST
    def generate(node : NumberLiteral)
      node.value.to_s
    end
  end
end
