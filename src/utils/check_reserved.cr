class CrystalScript::CodeGen
  @@js_reserved_keywords = ["break", "case", "catch", "class", "const",
    "continue", "debugger", "default", "delete", "do", "else", "export",
    "extends", "finally", "for", "function", "if", "import", "in",
    "instanceof", "new", "return", "super", "switch", "this", "throw",
    "try", "typeof", "var", "void", "while", "with", "yield"]

  def self.is_reserved(name)
    @@js_reserved_keywords.any?(name)
  end
end
