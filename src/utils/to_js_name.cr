class CrystalScript::CodeGen
  def self.to_js_name(named_type : NamedType)
    CrystalScript::GLOBAL_CLASS + "." + named_type.full_name.gsub("::", ".")
  end

  def self.to_js_name(named_type : GenericInstanceType)
    self.to_js_name(named_type.generic_type)
  end

  def self.to_js_name(_type : Nil | Type)
    nil
  end
end
