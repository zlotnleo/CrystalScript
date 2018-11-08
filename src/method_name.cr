module CrystalScript
  def self.convert_method_name(crystal_name : String, global)
    substitutions = [
      {"+", "__PLUS__"},
      {"-", "__MINUS__"},
      {"*", "__ASTERISK__"},
      {"/", "__FORWARDSLASH__"},
      {"^", "__CARET__"},
      {">", "__GREATERTHAN__"},
      {"<", "__LESSTHAN__"},
      {"=", "__EQUAL__"},
    ]

    name = crystal_name
    substitutions.each do |str, replacement|
      name = name.gsub(str, replacement)
    end

    name
  end
end
