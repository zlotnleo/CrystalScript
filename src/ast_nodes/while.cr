module CrystalScript
  class CodeGen
    private def generate(node : While)
      <<-WHILE
      while (Crystal__conditional(#{generate node.cond})) {
      #{CrystalScript.indent(generate node.body)}
      }
      WHILE
    end
  end
end
