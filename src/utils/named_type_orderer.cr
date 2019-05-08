class CrystalScript::NamedTypeOrderer
  getter types = Set(Crystal::NamedType | GenericInstanceType).new

  def visit(type : GenericType)
    type.generic_types.values.reject(&.unbound?).each do |bound_instance_type|
      visit bound_instance_type.as GenericInstanceType
    end
  end

  def visit(type : NamedType | GenericInstanceType)
    @types << type
    type.types?.try &.values.each do |sub_t|
      visit sub_t
    end
  end

  private class Vertex
    property? visited = false
    getter :type
    def initialize(@type : Type)
    end
    def to_s(io)
      io << "Vertex(#{type})"
    end
  end

  private def toposort(vertices, mapping, relation)
    order = [] of Type
    vertices.each do |v|
      unless v.visited?
        toposort_visit(v, order, mapping, relation)
      end
    end
    order
  end

  private def toposort_visit(v, order, mapping, relation) : Nil
    v.visited = true
    unless (nodes = relation.call(v.type)).nil?
      nodes.each do |p_type|
        unless p_type.nil?
          p_vertex = mapping[p_type]?

          if p_vertex.nil?
            CrystalScript.logger.error("Type #{p_type} was not visited!")
          else
            unless p_vertex.visited?
              toposort_visit(p_vertex, order, mapping, relation)
            end
          end
        end
      end
    end
    order << v.type
  end

  def in_mixin_order(&block)
    mapping = {} of (NamedType | GenericInstanceType) => Vertex
    vertices = [] of Vertex

    @types.each do |t|
      v = Vertex.new t
      vertices << v
      mapping[t] = v
    end

    toposort(vertices, mapping, ->(t : NamedType | GenericInstanceType){
      including_types = t.parents.dup || [] of Type
      including_types.delete t.superclass
      including_types
    }).each do |t|
      yield t
    end
  end

  def in_subclass_namespace_order(&block)
    mapping = {} of (NamedType | GenericInstanceType) => Vertex
    vertices = [] of Vertex

    @types.each do |t|
      v = Vertex.new t
      vertices << v
      mapping[t] = v
    end

    toposort(vertices, mapping, ->(t : NamedType | GenericInstanceType){
      if (namespace = t.namespace).is_a? Program || namespace.is_a? FileModule
        [t.superclass]
      else
        [t.superclass, namespace]
      end
    }).each do |t|
      yield t
    end
  end

  def in_any_order(&block)
    @types.each do |t|
      yield t
    end
  end
end
