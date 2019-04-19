module CrystalScript
  @@method_rename_substitutions = [
    {"+", "__PLUS__"},
    {"-", "__MINUS__"},
    {"*", "__ASTERISK__"},
    {"/", "__FORWARDSLASH__"},
    {"^", "__CARET__"},
    {">", "__GREATERTHAN__"},
    {"<", "__LESSTHAN__"},
    {"=", "__EQUAL__"},
    {"!", "__EXCLAIM__"},
    {"?", "__QUESTION__"},
    {"&", "__AMPERSAND__"},
    {"|", "__PIPE__"},
    {"~", "__TILDE__"},
    {"[", "__LBRACK__"},
    {"]", "__RBRACK__"},
    {"%", "__PERCENT__"},
  ]

  def self.convert_method_name(crystal_name : String)
    name = crystal_name
    @@method_rename_substitutions.each do |pattern, replacement|
      name = name.gsub(pattern, replacement)
    end
    name
  end
end
