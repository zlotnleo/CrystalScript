class CrystalScript::CodeGen
  def generate(node : Def)
    # Ignore primitive annotation
    return "" if (a = node.annotations) && a[@program.primitive_annotation]?



    owner_name = if (owner = node.owner).is_a? NamedType
      owner.full_name + " (full)"
    else
      owner.to_s + " (not named, to_s)"
    end
    # puts "to-be-defined(name: #{node.name}, owner: #{owner_name} (#{node.owner.class}))"

    # TODO: overloading, splats, named arguments, super, etc.

    String.build do |str|
      str << CrystalScript.global_class << "."
      case node.owner
      when Program
        str << node.name
      when NamedType
        no = node.owner.as(NamedType)
        str << no.full_name.gsub("::", ".") << "."
        if no.is_a? MetaclassType
          str << "prototype."
        end
        str << node.name
      else
        raise "Def has owner #{node.owner}, which is neither Program not a NamedType"
      end
      str << " = new Crystal__function(function("
      unless node.args.empty?
        node.args[0...-1].each do |arg|
          str << arg.name << ", "
        end
        str << node.args[-1].name
      end
      str << ") {\n"
      str << CrystalScript.indent(generate(node.body))
      str << "}, ["
      node.args.each do |arg|
        str << "{ name: '#{arg.name}'"
        unless (dv = arg.default_value).nil?
          str << ", default: (#{generate(dv)})"
        end
        str << " },"
      end
      str << "], /* splat_index??? */)"
    end
  end
end
