require "crustache"

module CrystalScript::CodeGen::Templates
  TYPE_DECLARATION = Crustache.parse <<-TYPE_DECLARATION
  {{{TypeName}}} = function (){
    {{#is_object}}
      this.$class_vars = Object.create(null);
    {{/is_object}}
    {{#has_superclass}}
      {{{SuperClass}}}.call(this);
    {{/has_superclass}}
    {{#included_modules}}
      {{{Module}}}.call(this);
    {{/included_modules}}
  };

  TYPE_DECLARATION
end
