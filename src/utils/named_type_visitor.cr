class CrystalScript::NamedTypeVisitor < Crystal::Visitor
  @types = [] of Crystal::NamedType

  def visit(node : ModuleDef | ClassDef)
    @types << node.resolved_type
    node.accept_children(self)
  end

  def visit(node : ASTNode)
    node.accept_children(self)
  end

  def in_namespace_order
    @types.sort_by do |t|
      t.full_name.scan("::").size
    end.each do |t|
      yield t
    end
  end
end
