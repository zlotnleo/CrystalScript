class CrystalScript::CodeGen
  private def generate(node : Expressions)
    code_a = node.expressions
      .map { |expression| generate(expression)}
      .select { |exp_code| !exp_code.blank? }
    return "" if code_a.empty?
    String.build do |str|
      code_a[0...-1].each do |code|
        str << code << ";\n"
      end
      str << code_a[-1] << ";"
    end
  end
end
