class CrystalScript::CodeGen
  def generate(node : Def)
    # Ignore primitive annotation
    return "" if (a = node.annotations) && a[@program.primitive_annotation]?

    owner_name = if (owner = node.owner).is_a? NamedType
      owner.full_name + " (full)"
    else
      owner.to_s + " (not named, to_s)"
    end
    return "to-be-defined(name: #{node.name}, owner: #{owner_name} (#{node.owner.class}))"

    # TODO: do overloading, splat expansion, named arguments, etc.

    # String.build do |str|
    #   str << CrystalScript.global_class << "."
    #   case node.owner
    #   when Program
    #     str << node.name
    #   when NamedType
    #     no = node.owner.as(NamedType)
    #     str << no.full_name.gsub("::", ".") << "."
    #     if no.is_a? MetaclassType
    #       str << "prototype."
    #     end
    #     str << node.name
    #   else
    #     raise "Def has owner #{node.owner}, which is neither Program not a NamedType"
    #   end
    #   str << " = function() {\n"
    #   str << CrystalScript.indent(generate(node.body))
    #   str << "\n}"
    # end
  end
end
