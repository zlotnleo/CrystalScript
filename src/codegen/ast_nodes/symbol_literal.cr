class CrystalScript::CodeGen
  private def generate(node : SymbolLiteral)
    "new #{CrystalScript.global_class}.Symbol()"
  end
end
