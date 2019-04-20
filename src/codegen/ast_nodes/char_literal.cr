class CrystalScript::CodeGen
  private def generate(node : CharLiteral)
    "new #{CrystalScript::GLOBAL_CLASS}.Char()"
  end
end
