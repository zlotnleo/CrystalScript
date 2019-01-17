module CrystalScript
  class CodeGen
    private def generate(node : Break)
      exp = node.exp
      if exp.nil?
        return "break"
      else
        return "return #{generate exp}"
      end
    end
  end
end
