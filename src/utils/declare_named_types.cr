module CrystalScript
  def self.declare_named_types(node)
    ntv = NamedTypeVisitor.new
    ntv.accept(node)
    String.build do |str|
      ntv.traverse_tree do |named_type|
        puts named_type.class
        case named_type
        when PrimitiveType
          str << "const Crystal__" if named_type.namespace.is_a? Program
          str << named_type.to_s.gsub("::", ".")
          str << " = class {};\n"
        when NonGenericModuleType, NonGenericClassType, MetaclassType
          str << "const " if named_type.namespace.is_a? Program
          str << named_type.to_s.gsub("::", ".")
          str << " = class {};\n"
        else
          # TODO!
          str << "const " << named_type.to_s.gsub("::", ".")
          str << " = {}; // Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
