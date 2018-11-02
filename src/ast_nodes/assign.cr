module CrystalScript
  class AST
    def self.generate(node : Assign)
      target = self.generate(node.target)
      value = self.generate(node.value)
      "#{target} = #{value}"
    end
  end
end
