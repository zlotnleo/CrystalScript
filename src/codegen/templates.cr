require "crustache"

module CrystalScript::Templates
  INIT_CRYSTALSCRIPT = Crustache.parse <<-INIT_CRYSTALSCRIPT
  const #{CrystalScript::GLOBAL_CLASS} = Object.create(null);
  #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::NULL_CLASS} = function(){};
  #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::NULL_CLASS}.prototype = null;
  #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::METHOD_CLASS} = class {
    constructor(funcs) { this.funcs = funcs; }
    call(this_arg, block, ...arg_vals) {
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
    }
  }

  INIT_CRYSTALSCRIPT

  OBJECT_TYPE_DECLARATION = Crustache.parse <<-OBJECT_TYPE_DECLARATION
  #{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}} = class extends #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::NULL_CLASS} {
    constructor() {
      super();
      this.$instance_vars = Object.create(null);
    }
  };

  OBJECT_TYPE_DECLARATION

  TYPE_DECLARATION = Crustache.parse <<-TYPE_DECLARATION
  #{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}} = class extends #{CrystalScript::GLOBAL_CLASS}.{{#has_superclass}}{{{SuperClass}}}{{/has_superclass}}{{^has_superclass}}#{CrystalScript::NULL_CLASS}{{/has_superclass}} {};
  Object.defineProperty(#{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}}.prototype.constructor, 'name', {value: '{{{DisplayName}}}'});

  TYPE_DECLARATION

  HAS_INSTANCE = Crustache.parse <<-HAS_INSTANCE
  ((typeTag) => {
    Object.defineProperty(#{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}}, Symbol.hasInstance, {value: instance => instance[typeTag]});
    #{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}}.prototype[typeTag] = true;
  })(Symbol());
  HAS_INSTANCE

  APPLY_INCLUDE = Crustache.parse <<-APPLY_INCLUDE
  Object.assign(#{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}}.prototype{{#included_modules}}, #{CrystalScript::GLOBAL_CLASS}.{{{Module}}}.prototype{{/included_modules}});

  APPLY_INCLUDE

  APPLY_EXTEND = Crustache.parse <<-APPLY_EXTEND
  Object.assign(#{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}}{{#extended_modules}}, #{CrystalScript::GLOBAL_CLASS}.{{{Module}}}.prototype{{/extended_modules}})

  APPLY_EXTEND

  DEFINE_METHODS = Crustache.parse <<-DEFINE_METHODS
  #{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}}{{#is_instance}}.prototype{{/is_instance}}['{{{MethodName}}}'] = new #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::METHOD_CLASS}([{{#funcs}}{
    func: function {{=<% %>=}}({<%#func_args%><%& ArgName%><%#has_default%> = <%& DefaultVal%><%/has_default%>, <%/func_args%>})<%={{ }}=%> {
    {{{MethodBody}}}
    },
    min_args: {{{MinArgs}}},
    max_args: {{{MaxArgs}}},
    has_block: {{{HasBlock}}},
    args: [],
    {{#has_external_names}}
    external_names: { {{#external_names}}
      '{{{ExternalName}}}': '{{{InternalName}}}',{{/external_names}}
    },
    {{/has_external_names}}
  },{{/funcs}}]);

  DEFINE_METHODS

  CLASS_NEW = Crustache.parse <<-CLASS_NEW
  #{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}}.new = function(this_arg, block, ...args) {
    let _ = new #{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}}();
    {{#has_init}}
    _.initialize.call(_, block, ...args);
    {{/has_init}}
    return _;
  };

  CLASS_NEW
end
