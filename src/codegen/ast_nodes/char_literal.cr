class CrystalScript::CodeGen
  private def generate(node : CharLiteral)
    "new #{CrystalScript.global_class}.Char()"
  end
end
