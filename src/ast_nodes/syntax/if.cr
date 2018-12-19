module CrystalScript
  class CodeGen
    def generate(node : If)
"if (Crystal__conditional(#{generate node.cond})) {
  #{generate node.then}
} else {
  #{generate node.else}
}"
    end
  end
end
