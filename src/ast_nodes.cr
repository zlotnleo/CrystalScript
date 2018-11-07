require "./ast_nodes/*"

module CrystalScript
  include Crystal
  class CodeGen
    def initialize
      @local_variables_scope = [[] of String]
    end

    def generate(node : ASTNode)
      raise NotImplementedError.new("Unsupported AST node #{node.class}")
    end
  end
end
