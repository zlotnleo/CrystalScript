require "./ast_nodes/**"

module CrystalScript
  class CodeGen
    property program : Program

    @local_variables_scope = [[] of String]

    def initialize(@program)
    end

    def generate(node : ASTNode)
      raise NotImplementedError.new("Unsupported AST node #{node.class}")
    end
  end
end
