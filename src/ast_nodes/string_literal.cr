module CrystalScript
  class AST
    def generate(node : StringLiteral)
      js_class = CrystalScript.get_primitive_js_class(String)
      "new #{js_class}(\"#{node.value}\")"
    end
  end
end
