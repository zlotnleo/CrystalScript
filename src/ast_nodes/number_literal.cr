module CrystalScript
  class AST
    def generate(node : NumberLiteral)
      js_class = CrystalScript.get_number_class(node.kind)
      "new #{js_class}(\"#{node.value}\")"
    end
  end
end
