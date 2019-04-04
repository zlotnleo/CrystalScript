class CrystalScript::CodeGen
  def self.to_js_name(named_type)
    case named_type
    when Nil
      return nil
    when NamedType
      return CrystalScript.global_class + "." + named_type.full_name.gsub("::", ".")
    else
      raise "Trying to get name of unnamed type " + named_type.to_s
    end
    # if named_type.nil?
    #   return nil
    # end


  end
end
