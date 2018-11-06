module CrystalScript
  class AST
    def generate(node : Call)
      # TODO: named args
      # TODO: blocks
      code = ""
      obj = node.obj
      if obj.is_a?(ASTNode)
        code += self.generate(obj) + "."
      end
      code += CrystalScript.convert_method_name(node.name, node.global?) + "("
      node.args[0...(node.args.size - 1)].each do |arg|
        code += self.generate(arg) + ", "
    end
    code + self.generate(node.args[-1]) + ")"
    end
  end
end
