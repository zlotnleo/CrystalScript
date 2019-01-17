module CrystalScript
  class CodeGen
    private def generate(node : Call)
      # TODO: named args
      # TODO: blocks
      code = ""
      obj = node.obj
      if obj.is_a?(ASTNode)
        code += generate(obj) + "."
      end

      code += CrystalScript.convert_method_name(node.name, node.global?) + "("
      unless node.args.empty?
        node.args[0...(node.args.size - 1)].each do |arg|
          code += generate(arg) + ", "
        end
        code += generate(node.args[-1])
      end
      code + ")"
    end
  end
end
