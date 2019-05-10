class CrystalScript::NamedTypeOrderer
  @all_types = Set(NamedType | GenericInstanceType).new

  def initialize(program : Program)
    visit(program)
  end

  private def visit(type : Type)
    if @all_types.add? type
      visit (type.types?.try &.values)
      if type.is_a? GenericType
        visit type.generic_types.values.reject(&.unbound?)
        # visit type.generic_types.values
      elsif type.is_a? GenericInstanceType
        visit type.parents.reject(&.unbound?)
        # visit type.parents
      end
    end
  end

  private def visit(types : Array)
    types.each { |type| visit type }
  end

  private def visit(_nil : Nil)
  end

  class Toposort
    private class Vertex
      property? visited = false
      getter :type
      def initialize(@type : Type)
      end
      def to_s(io)
        io << "Vertex(#{type})"
      end
    end

    @mapping = {} of Type => Vertex
    @vertices = [] of Vertex

    def initialize(types)
      types.each do |t|
        v = Vertex.new t
        @vertices << v
        @mapping[t] = v
      end
    end

    def toposort(relation, @label="")
      order = [] of Type
      @vertices.each do |v|
        unless v.visited?
          toposort_visit(v, order, relation)
        end
      end
      order
    end

    private def toposort_visit(v, order, relation) : Nil
      v.visited = true
      relation.call(v.type).try &.each do |p_type|
        unless p_type.nil?
          p_vertex = @mapping[p_type]?
          if p_vertex.nil?
            CrystalScript.logger.error("Type #{p_type} was not visited!")
            CrystalScript.logger.error("    bound: #{!p_type.unbound?} class: #{p_type.class}")
            CrystalScript.logger.error("    following #{@label} relation from #{v.type} (bound: #{!v.type.unbound?} class: #{v.type.class})")
          elsif !p_vertex.visited?
            toposort_visit(p_vertex, order, relation)
          end
        end
      end
      order << v.type
    end
  end

  def in_mixin_order(&block)
    Toposort.new(@all_types).toposort(->(t : NamedType | GenericInstanceType){
      including_types = t.parents.dup || [] of Type
      including_types.delete t.superclass
      if t.is_a? GenericType
        including_types.map! do |including_type|
          if including_type.is_a? GenericInstanceType && including_type.unbound?
            including_type.generic_type.as Type
          else
            including_type
          end
        end
      end
      including_types
    }).each do |t|
      yield t
    end
  end

  def in_subclass_namespace_order(&block)
    Toposort.new(@all_types).toposort(->(t : NamedType | GenericInstanceType){
      links = [] of Type
      if (superclass = t.superclass).is_a? GenericInstanceType && t.is_a? GenericType
        links << superclass.generic_type
      else
        links << superclass unless superclass.nil?
      end
      unless (namespace = t.namespace).is_a? Program || namespace.is_a? FileModule
        links << namespace
      end
      links
    }).each do |t|
      yield t
    end
  end

  def in_any_order(&block)
    @all_types.each do |v|
      yield v.type
    end
  end
end
