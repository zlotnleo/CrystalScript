module CrystalScript
  def self.convert_method_name(crystal_name : String, global)
    substitutions = [
      {/\+/, "__PLUS__"},
      {/-/, "__MINUS__"},
      {/\*/, "__ASTERISK__"},
      {/\//, "__FORWARDSLASH__"},
      {/\^/, "__CARET__"},
      {/>/, "__GREATERTHAN__"},
      {/</, "__LESSTHAN__"},
      {/=/, "__EQUAL__"},
      {/&/, "__AMPERSAND__"},
      {/\|/, "__PIPE__"},
      {/^class$/, "__CLASS_METHOD__"}
    ]

    name = crystal_name
    substitutions.each do |pattern, replacement|
      name = name.gsub(pattern, replacement)
    end

    name
  end
end
