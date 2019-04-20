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

  INIT_TYPE = Crustache.parse <<-INIT_TYPE
  Object.defineProperty({{{TypeName}}}.prototype.constructor, 'name', {value: '{{{DisplayName}}}'});
  {{{TypeName}}}.prototype = Object.assign(Object.create({{#has_superclass}}{{{SuperClass}}}.prototype{{/has_superclass}}{{^has_superclass}}null{{/has_superclass}}){{#included_modules}}, {{{Module}}}.prototype{{/included_modules}});
  {{{TypeName}}}.prototype.$included_modules = {{#has_superclass}}{{{SuperClass}}}.prototype.$included_modules{{/has_superclass}}{{^has_superclass}}[]{{/has_superclass}}{{#has_included_modules}}.concat([{{#included_modules}}{{{Module}}},{{/included_modules}}]){{/has_included_modules}};
  {{{TypeName}}}.prototype.constructor = {{{TypeName}}};

  INIT_TYPE
end
