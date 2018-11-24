module CrystalScript
  class CodeGen
    def generate(node : NilLiteral)
      js_class = CrystalScript.get_primitive_js_class(Nil)
      "new #{js_class}()"
    end
  end
end
