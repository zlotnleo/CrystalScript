class CrystalScript::NamedTypeOrderer
  getter types = Set(Crystal::NamedType).new

  def visit(named_type : NamedType)
    t = deinstantiate(named_type)
    @types << t
    named_type.types?.try &.values.each do |sub_t|
      visit sub_t
    end
  end

  private class Vertex
    property? visited = false
    getter :type
    def initialize(@type : NamedType)
    end
    def to_s(io)
      io << "Vertex(#{type})"
    end
  end

  private def deinstantiate(t : GenericInstanceType)
    t.generic_type
  end

  private def deinstantiate(t : Type)
    t
  end

  private def toposort(vertices, mapping, relation)
    order = [] of NamedType
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
          p_type = deinstantiate(p_type)
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
    mapping = {} of NamedType => Vertex
    vertices = [] of Vertex

    @types.each do |t|
      v = Vertex.new t
      vertices << v
      mapping[t] = v
    end

    toposort(vertices, mapping, ->(t : NamedType){
      including_types = t.parents.dup || [] of Type
      including_types.delete t.superclass
      including_types
    }).each do |t|
      yield t
    end
  end

  def in_subclass_namespace_order(&block)
    mapping = {} of NamedType => Vertex
    vertices = [] of Vertex

    @types.each do |t|
      v = Vertex.new t
      vertices << v
      mapping[t] = v
    end

    toposort(vertices, mapping, ->(t : NamedType){
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
