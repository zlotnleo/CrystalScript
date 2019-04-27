require "./codegen/**"
require "crustache"

class CrystalScript
  # class CodeGen
  #   @local_variables_scope = [[] of String]

  #   private def generate(node : ExpandableNode)
  #     if (expanded = node.expanded).nil?
  #       # raise ::Exception.new("The node #{node.class} should be expanded before code genration!")
  #       CrystalScript.logger.error("unexpanded expandable node #{node}")
  #       # TODO: fix temporary undefined for when method call is used a default
  #       return "undefined /* BUG: unexpanded expandable node #{node} */"
  #     else
  #       return generate(expanded)
  #     end
  #   end

  #   private def generate(node : ASTNode)
  #     raise NotImplementedError.new("Unsupported AST node #{node.class}")
  #   end
  # end
end
