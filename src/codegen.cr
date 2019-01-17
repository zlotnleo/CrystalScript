require "./ast_nodes/**"

module CrystalScript
  class CodeGen
    getter program : Program
    getter node : ASTNode

    @local_variables_scope = [[] of String]

    def initialize(@program, @node)
    end

    def generate
      # TODO: include JS sources for Crystal primitives

      # TODO: generate symbol table

      # TODO: declare top-level classes and modules

      generate(@node)
    end

    private def generate(node : ASTNode)
      raise NotImplementedError.new("Unsupported AST node #{node.class}")
    end
  end
end
