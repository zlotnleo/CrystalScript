module CrystalScript
  class AST
    def self.generate(node : NumberLiteral)
      node.value.to_s
    end
  end
end
