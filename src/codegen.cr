require "./js_helpers/**"
require "./codegen/**"
require "crustache"

module CrystalScript
  GLOBAL_CLASS = "Crystal__Program"
  METHOD_CLASS = "$crystal__method"

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
      code = Crustache.render CodeGen::Templates::INIT_GLOBAL_CLASS,  {
        "GlobalClass" => CrystalScript::GLOBAL_CLASS
      }
      code += Crustache.render CodeGen::Templates::CREATE_METHOD_CLASS, {
        "GlobalClass" => CrystalScript::GLOBAL_CLASS,
        "MethodClass" => CrystalScript::METHOD_CLASS
      }

      # TODO: generate symbol table

      @ntv.accept(@node)
      code += declare_named_types
      code += set_named_types_prototypes

      # code += generate(@node)
      code
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
