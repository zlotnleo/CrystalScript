module CrystalScript
  class CodeGen
    def generate(node : Expressions)
      String.build do |str|
        node.expressions.each do |expression|
          code = generate(expression)
          str << code << ";\n" unless code.blank?
        end
      end
    end
  end
end
