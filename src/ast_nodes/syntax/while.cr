module CrystalScript
  class CodeGen
    def generate(node : While)
      <<-WHILE
      while Crystal__conditional(#{generate node.cond}) {
        #{generate node.body}
      }
      WHILE
    end
  end
end
