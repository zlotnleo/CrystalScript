class CrystalScript::NamedTypeVisitor < Crystal::Visitor
  class TypeTree
    class Node
      property val : NamedType
      property children = [] of Node
      def initialize(@val)
      end
    end

    getter roots = [] of Node

    def insert(named_type)
      candidates = if named_type.namespace.is_a? Program
        @roots
      else
        insert(named_type.namespace).children
      end

      existing_node = candidates.find { |node| node.val == named_type }
      if existing_node.nil?
        new_node = Node.new(named_type)
        candidates << new_node
        return new_node
      end
      return existing_node
    end
  end

  @type_tree = TypeTree.new

  def visit(node : ModuleDef | ClassDef)
    @type_tree.insert(node.resolved_type)
    node.accept_children(self)
  end

  def visit(node : ASTNode)
    node.accept_children(self)
  end

  def traverse_tree(&block)
    @type_tree.roots.each do |root|
      stack = [root]
      until stack.empty?
        cur = stack.pop
        yield cur.val
        stack += cur.children
      end
    end
  end
end
