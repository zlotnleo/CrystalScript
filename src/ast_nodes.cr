require "./ast_nodes/*"

module CrystalScript
  include Crystal

  class AST
    def self.generate(node : ASTNode)
      raise NotImplementedError.new("Unsupported AST node #{node.class}")
    end
  end
end
