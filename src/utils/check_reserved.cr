class CrystalScript
  @@js_reserved_keywords = ["break", "case", "catch", "class", "const",
    "continue", "debugger", "default", "delete", "do", "else", "export",
    "extends", "finally", "for", "function", "if", "import", "in",
    "instanceof", "new", "return", "super", "switch", "this", "throw",
    "try", "typeof", "var", "void", "while", "with", "yield"]

  def self.reserved(name)
    @@js_reserved_keywords.any?(name)
  end

  def self.safe_var_name(name)
    return name unless reserved(name)
    return "$#{name}"
  end
end
