class CrystalScript::ExpressionGen
  def generate(node : ASTNode)
    "undefined /* #{node.class} */"
  end
end
