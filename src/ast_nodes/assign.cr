module CrystalScript
  class CodeGen
    def generate(node : Assign)
      target = self.generate(node.target)
      value = self.generate(node.value)
      current_scope = @local_variables_scope[0]
      if current_scope.includes?(target)
        return "#{target} = #{value}"
      end
      current_scope << target
      return "let #{target} = #{value}"
    end
  end
end
