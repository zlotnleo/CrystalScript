class CrystalScript::CodeGen
  def generate(node : Macro)
    # Macros are already expanded
    # The definition are no longer needed
    return ""
  end
end
