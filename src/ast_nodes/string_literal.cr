class CrystalScript::CodeGen
  private def generate(node : StringLiteral)
    js_class = CrystalScript.get_primitive_js_class(String)
    js_string = node.value
      .gsub('\n', "\\n")
    "new #{js_class}(\"#{js_string}\")"
  end
end
