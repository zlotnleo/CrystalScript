class CrystalScript::NamedTypeVisitor < Crystal::Visitor
  @types = [] of Crystal::NamedType

  def visit(node : ModuleDef | ClassDef)
    # Do not allow duplicates
    @types << node.resolved_type if @types.find(&.== node.resolved_type).nil?
    node.accept_children(self)
  end

  def visit(node : ASTNode)
    node.accept_children(self)
  end

  def in_namespace_order(&block)
    @types.sort_by { |t| t.full_name.scan("::").size }.each do |t|
      yield t
    end
  end

  private class Vertex
    property? visited = false
    getter :type
    def initialize(@type : NamedType)
    end
  end

  private def toposort(vertices, mapping)
    order = [] of NamedType
    vertices.each do |v|
      unless v.visited?
        toposort_visit(v, order, mapping)
      end
    end
    order
  end

  private def toposort_visit(v, order, mapping) : Nil
    v.visited = true
    if (parents = v.type.parents).nil?
      parents = [] of Crystal::NamedType
    end
    parents.each do |p_type|
      p_vertex = mapping[p_type]
      unless p_vertex.visited?
        toposort_visit(p_vertex, order, mapping)
      end
    end
    order << v.type
  end

  def in_subclass_mixin_order(&block)
    mapping = {} of NamedType => Vertex
    vertices = [] of Vertex

    @types.each do |t|
      v = Vertex.new t
      vertices << v
      mapping[t] = v
    end

    toposort(vertices, mapping).each do |t|
      yield t
    end
  end
end
