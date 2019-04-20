class CrystalScript::CodeGen
  private def generate(node : SymbolLiteral)
    "new #{CrystalScript::GLOBAL_CLASS}.Symbol()"
  end
end
