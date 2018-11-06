module CrystalScript
  class AST
    def generate(node : NumberLiteral)
      js_class = CrystalScript.get_primitive_js_class(Number, node.kind)
      "new #{js_class}(\"#{node.value}\")"
    end
  end
end
