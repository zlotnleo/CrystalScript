class CrystalScript::CodeGen
  def self.to_js_name(named_type)
    case named_type
    when Nil
      return nil
    when NamedType
      return CrystalScript::GLOBAL_CLASS + "." + named_type.full_name.gsub("::", ".")
    when GenericInstanceType
      return self.to_js_name(named_type.generic_type)
    else
      raise "Trying to get name of unnamed type #{named_type.to_s} : #{named_type.class}"
    end
    # if named_type.nil?
    #   return nil
    # end

  end
end
