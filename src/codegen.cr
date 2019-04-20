require "./js_helpers/**"
require "./codegen/**"
require "crustache"

module CrystalScript
  class_getter global_class = "Crystal__Program"

  def self.method_class
    self.global_class + ".$crystal__method"
  end

  class CodeGen
    getter program : Program
    getter node : ASTNode

    @local_variables_scope = [[] of String]
    @ntv = NamedTypeVisitor.new

    def initialize(@program, @node)
      # @program.file_modules.each do |filename, mod|
      #   info = <<-INFO
      #     def_instances: #{mod.def_instances}
      #     vars: #{mod.vars}
      #   INFO
      #   puts "#{filename}\n#{info}"
      # end
      # puts "\n\n"
    end

    def generate
      code = init_global_class

      # TODO: generate symbol table

      # program = result.program
      # puts <<-PROGRAM
      # symbols: #{program.symbols}

      # global_vars: #{program.global_vars}

      # vars: #{program.vars} : #{program.vars.class}

      # requires: #{program.requires}

      # file_modules: #{program.file_modules} : #{program.file_modules.class}

      # PROGRAM

      @ntv.accept(@node)
      code += declare_named_types
      code += set_named_types_prototypes

      # @ntv.traverse_tree do |named_type|
      #   nt = named_type

      #   begin
      #     including_types = nt.including_types
      #   rescue
      #   end

      #   begin
      #     direct_subclasses = nt.subclasses
      #   rescue
      #   end

      #   puts <<-NAMED_INFO
      #   "#{nt.name}:
      #       including_types: #{including_types}
      #       subclasses: #{direct_subclasses}
      #   NAMED_INFO
      #   # defs: #{nt.defs}
      # end

      # code += CrystalScript.include_js_sources

      # code += generate(@node)
      code
    end

    private def init_global_class
      template = Crustache.parse "const {{GlobalClass}} = Object.create(null);\n"
      Crustache.render template, {"GlobalClass" => CrystalScript.global_class}
    end

    private def generate(node : ExpandableNode)
      if (expanded = node.expanded).nil?
        # raise ::Exception.new("The node #{node.class} should be expanded before code genration!")
        CrystalScript.logger.error("unexpanded expandable node #{node}")
        return "/* BUG: unexpanded expandable node #{node} */"
      else
        return generate(expanded)
      end
    end

    private def generate(node : ASTNode)
      raise NotImplementedError.new("Unsupported AST node #{node.class}")
    end
  end
end
