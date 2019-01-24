class CrystalScript::CodeGen
  def declare_named_types
    String.build do |str|
      @ntv.traverse_tree do |named_type|
        case named_type
        when NonGenericModuleType, NonGenericClassType, MetaclassType, PrimitiveType
          str << CrystalScript.global_class << "." << named_type.to_s.gsub("::", ".")
          str << " = class {};\n"
        else
          # TODO!
          # str << "const Crystal_Program." << named_type.to_s.gsub("::", ".")
          str << "// Not implemented: " << named_type << " : " << named_type.class << "\n"
        end
      end
    end
  end
end
