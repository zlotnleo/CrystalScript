module CrystalScript
  class AST
    def self.generate(node : Expressions)
      String.build do |str|
        node.expressions.each do |expression|
          str << self.generate(expression) << ";\n"
        end
      end
    end
  end
end
