require "./ast_nodes/**"

module CrystalScript
  class CodeGen
    getter program : Program
    getter node : ASTNode

    @local_variables_scope = [[] of String]

    def initialize(@program, @node)
      @program.file_modules.each do |filename, mod|
        info = <<-INFO
          def_instances: #{mod.def_instances}
          vars: #{mod.vars}
        INFO
        puts "#{filename}\n#{info}"
      end
      puts "\n\n"
    end

    def generate
      code = "const Crystal_Program = class {};\n"

      # TODO: generate symbol table

      code += CrystalScript.declare_named_types(@node)

      # TODO: include JS sources for Crystal primitives
      # Note: the step above has already declared classes from prelude

      code += generate(@node)

      code
    end

    private def generate(node : ASTNode)
      raise NotImplementedError.new("Unsupported AST node #{node.class}")
    end
  end
end
