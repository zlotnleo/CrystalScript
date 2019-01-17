module CrystalScript
  class CodeGen
    private def generate(node : BoolLiteral)
      js_class = CrystalScript.get_primitive_js_class(Bool)
      "new #{js_class}(#{node.value ? "true" : "false"})"
    end
  end
end
