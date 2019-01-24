require "./ast_nodes/**"

module CrystalScript
  def self.global_class
    "Crystal__Program"
  end

  class CodeGen
    getter program : Program
    getter node : ASTNode

    @local_variables_scope = [[] of String]
    @ntv = NamedTypeVisitor.new

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
      code = "const #{CrystalScript.global_class} = class {};\n"

      # TODO: generate symbol table

      @ntv.accept(@node)
      code += declare_named_types

      @ntv.traverse_tree do |named_type|
        nt = named_type

        begin
          including_types = nt.including_types
        rescue
        end

        begin
          direct_subclasses = nt.subclasses
        rescue
        end

        puts <<-NAMED_INFO
        "#{nt.name}:
            including_types: #{including_types}
            subclasses: #{direct_subclasses}
        NAMED_INFO
        # defs: #{nt.defs}
      end

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