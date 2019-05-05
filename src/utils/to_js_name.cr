class CrystalScript
  def self.to_js_name(named_type : NamedType)
    named_type.full_name.gsub("::", ".")
  end

  def self.to_js_name(named_type : GenericInstanceType)
    self.to_js_name(named_type.generic_type)
  end

  def self.to_js_name(path : Path)
    String.build do |str|
      str << CrystalScript::GLOBAL_CLASS
      path.names.each do |name|
        str << "." << name
      end
    end
  end

  def self.to_js_name(_type : Nil | Type)
    nil
  end
end
