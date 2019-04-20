require "crustache"

module CrystalScript::CodeGen::Templates
  INIT_GLOBAL_CLASS = Crustache.parse <<-INIT_GLOBAL_CLASS
  const {{GlobalClass}} = Object.create(null);

  INIT_GLOBAL_CLASS

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

  CREATE_METHOD_CLASS = Crustache.parse <<-CREATE_METHOD_CLASS
  {{{GlobalClass}}}.{{{MethodClass}}} = function (funcs) { this.funcs = funcs; }
  {{{GlobalClass}}}.{{{MethodClass}}}.prototype.call = function(this_arg, block, ...arg_vals) {
      let num_args = arg_vals.length;
      let initial_match = this.funcs.filter(func => num_args >= func.min_args && num_args <= func.max_args && (block === func.has_block));

      /* BEGIN: Temporary until overloading on type */
      if(initial_match.length != 1) {
          throw `Found ${initial_match.length} mathing methods`;
      }
      let func = initial_match[0];
      /* END: Temporary until overloading on type */

      let external_check = Object.prototype.hasOwnProperty.call(func, 'external_names');
      let positional = [];
      let named = [];
      for(let arg of arg_vals) {
          if (Object.prototype.hasOwnProperty.call(arg, 'name')) {
              if (external_check && Object.prototype.hasOwnProperty.call(func.external_names, arg.name)) {
                  arg.name = func.external_names[arg.name];
              }
              named.push(arg);
          } else { positional.push(arg); }
      }
      let args = Object.create(null);
      for(let i = 0; i < positional.length; i++) { args[func.args[i].name] = positional[i].value; }
      for(let named_arg of named) { args[named_arg.name] = named_arg.value; }
      return func.func.call(this_arg, args);
  };

  CREATE_METHOD_CLASS
end
