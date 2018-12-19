require "./ast_nodes/**"

module CrystalScript
  class CodeGen
    @local_variables_scope = [[] of String]

    def generate(node : ASTNode)
      raise NotImplementedError.new("Unsupported AST node #{node.class}")
    end
  end
end
