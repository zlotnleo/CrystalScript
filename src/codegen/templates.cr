require "crustache"

module CrystalScript::Templates
  INIT_CRYSTALSCRIPT = Crustache.parse <<-INIT_CRYSTALSCRIPT
  const #{CrystalScript::GLOBAL_CLASS} = Object.create(null);
  #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::TRUTHY} = v => !(v === #{CrystalScript::GLOBAL_CLASS}.nil || v === #{CrystalScript::GLOBAL_CLASS}.false);
  #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::IS_A} = (obj, type) => obj instanceof type ? #{CrystalScript::GLOBAL_CLASS}.true : #{CrystalScript::GLOBAL_CLASS}.false;
  #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::SIMPLE_LITERAL} = (type, v) => { let _ = new type; _.$value = v; return _; };
  #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::RETURN_EXCEPTION} = function(value) { this.value = value; };

  INIT_CRYSTALSCRIPT

  INIT_LITERALS = Crustache.parse <<-INIT_LITERALS
  #{CrystalScript::GLOBAL_CLASS}.nil = new #{CrystalScript::GLOBAL_CLASS}.Nil();
  #{CrystalScript::GLOBAL_CLASS}.true = new #{CrystalScript::GLOBAL_CLASS}.Bool();
  #{CrystalScript::GLOBAL_CLASS}.false = new #{CrystalScript::GLOBAL_CLASS}.Bool();
  INIT_LITERALS

  OBJECT_TYPE_DECLARATION = Crustache.parse <<-OBJECT_TYPE_DECLARATION
  #{CrystalScript::GLOBAL_CLASS}['Object'] = class {
    constructor() {
      this.$instance_vars = Object.create(null);
    }
  };

  OBJECT_TYPE_DECLARATION

  INSTANCE_VAR_INIT = Crustache.parse <<-INSTANCE_VAR_INIT

    constructor() {
      super();
      {{#instance_vars}}
      this.$instance_vars['{{{Name}}}'] = {{{Value}}};
      {{/instance_vars}}
    }

  INSTANCE_VAR_INIT

  TYPE_DECLARATION = Crustache.parse <<-TYPE_DECLARATION
  #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}} = class{{#has_superclass}} extends #{CrystalScript::GLOBAL_CLASS}{{#super_path}}['{{{Type}}}']{{/super_path}}{{/has_superclass}} { {{{instance_var_init}}} };
  Object.defineProperty(#{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}.prototype.constructor, 'name', {value: '{{{DisplayName}}}'});

  TYPE_DECLARATION

  CLASS_VARS = Crustache.parse <<-CLASS_VARS
  #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}.$class_vars = Object.create(null);
  {{#initialisers}}
  #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}.$class_vars['{{{Name}}}'] = {{{Value}}};
  {{/initialisers}}
  CLASS_VARS

  HAS_INSTANCE = Crustache.parse <<-HAS_INSTANCE
  ((typeTag) => {
    Object.defineProperty(#{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}, Symbol.hasInstance, {value: instance => instance[typeTag]});
    #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}.prototype[typeTag] = true;
    {{#generic_instances}}
    #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}.prototype[typeTag] = true;
    {{/generic_instances}}
  })(Symbol());

  HAS_INSTANCE

  APPLY_INCLUDE = Crustache.parse <<-APPLY_INCLUDE
  Object.assign(#{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}.prototype{{#included_modules}}, #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}.prototype{{/included_modules}});

  APPLY_INCLUDE

  APPLY_EXTEND = Crustache.parse <<-APPLY_EXTEND
  Object.assign(#{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}{{#extended_modules}}, #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}.prototype{{/extended_modules}});

  APPLY_EXTEND

  CLASS_NEW = Crustache.parse <<-CLASS_NEW
  #{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}}.new = function(self, block, ...args) {
    let _ = new #{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}}();
    {{#has_init}}
    _.initialize.call(_, block, ...args);
    {{/has_init}}
    return _;
  };

  CLASS_NEW

  CLASS = Crustache.parse <<-CLASS
  #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}
  CLASS

  METHOD = Crustache.parse <<-METHOD
  {{#class}}#{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}{{#instance_method}}.prototype{{/instance_method}}{{/class}}['{{{MethodName}}}({{#arg_types}}{{{Type}}},{{/arg_types}})']
  METHOD

  DEFINE_METHOD = Crustache.parse <<-DEFINE_METHOD
  {{{MethodName}}} = function({{#args}}{{{Arg}}},{{/args}}) {
  {{{Body}}}
  };

  DEFINE_METHOD

  ALLOCATE = Crustache.parse <<-ALLOCATE
  #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}['allocate'][''] = function() {
    return new #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}();
  };

  ALLOCATE

  CALL = Crustache.parse <<-CALL
  {{{Object}}}{{{MethodName}}}({{#args}}{{{Arg}}}{{/args}})
  CALL

  TUPLE_LITERAL = Crustache.parse <<-TUPLE_LITERAL
  (() => {
    let _ = new #{CrystalScript::GLOBAL_CLASS}['Tuple({{#type_args}}{{{Type}}}{{^last}},{{/last}}{{/type_args}})'];
    _.$value = [{{#values}}{{{Value}}},{{/values}}];
    return _;
  })()
  TUPLE_LITERAL

  SIMPLE_LITERAL = Crustache.parse <<-SIMPLE_LITERAL
  #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::SIMPLE_LITERAL}(#{CrystalScript::GLOBAL_CLASS}['{{{Type}}}'], {{{Value}}})
  SIMPLE_LITERAL

  WHILE = Crustache.parse <<-WHILE
  (() => {
    while(#{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::TRUTHY}({{{Condition}}})){
    {{{Body}}}
    }
    return #{CrystalScript::GLOBAL_CLASS}.nil
  })()
  WHILE
end
