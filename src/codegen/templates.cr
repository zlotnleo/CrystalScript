require "crustache"

module CrystalScript::Templates
  INIT_CRYSTALSCRIPT = Crustache.parse <<-INIT_CRYSTALSCRIPT
  const #{CrystalScript::GLOBAL_CLASS} = Object.create(null);
  #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::TRUTHY} = v => !(v === #{CrystalScript::GLOBAL_CLASS}.nil || v === #{CrystalScript::GLOBAL_CLASS}.false);

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

  TYPE_DECLARATION = Crustache.parse <<-TYPE_DECLARATION
  #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}} = class{{#has_superclass}} extends #{CrystalScript::GLOBAL_CLASS}{{#super_path}}['{{{Type}}}']{{/super_path}}{{/has_superclass}} {};
  Object.defineProperty(#{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}.prototype.constructor, 'name', {value: '{{{DisplayName}}}'});

  TYPE_DECLARATION

  HAS_INSTANCE = Crustache.parse <<-HAS_INSTANCE
  ((typeTag) => {
    Object.defineProperty(#{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}, Symbol.hasInstance, {value: instance => instance[typeTag]});
    #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}.prototype[typeTag] = true;
  })(Symbol());

  HAS_INSTANCE

  APPLY_INCLUDE = Crustache.parse <<-APPLY_INCLUDE
  Object.assign(#{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}.prototype{{#included_modules}}, #{CrystalScript::GLOBAL_CLASS}{{#path}}['{{{Type}}}']{{/path}}.prototype{{/included_modules}});

  APPLY_INCLUDE

  APPLY_EXTEND = Crustache.parse <<-APPLY_EXTEND
  Object.assign(#{CrystalScript::GLOBAL_CLASS}.{{{TypeName}}}{{#extended_modules}}, #{CrystalScript::GLOBAL_CLASS}.{{{Module}}}.prototype{{/extended_modules}})

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

  CALL = Crustache.parse <<-CALL
  ($obj => $obj['{{{MethodName}}}'].call($obj,{{{HasBlock}}}{{#args}}, {value:({{{Value}}})}{{/args}}{{#named_args}}, {value:({{{Value}}}), name: {{{Name}}}}{{/named_args}}))({{{Object}}})
  CALL
end
