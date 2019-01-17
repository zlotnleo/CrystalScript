module CrystalScript
  class CodeGen
    private def generate(node : If)
      <<-IF
      if (Crystal__conditional(#{generate node.cond})) {
      #{CrystalScript.indent(generate node.then)}
      } else {
      #{CrystalScript.indent(generate node.else)}
      }"
      IF
    end
  end
end
