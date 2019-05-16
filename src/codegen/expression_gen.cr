class CrystalScript::ExpressionGen
  class UnsafeMethodError < Exception
  end

  # Only generates the method body
  def generate(node : Def)
    String.build do |str|
      local_vars = node.vars.try &.select { |name, meta_var| meta_var.assigned_to? }.map(&.[](0))
      unless local_vars.nil? || local_vars.empty?
        str << "let " << local_vars.join(",") << ";\n"
      end
      str << <<-DEF
      try {
        return #{generate node.body};
      } catch($err) {
        if ($err instanceof #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::RETURN_EXCEPTION}) {
          return $err.value;
        } else {
          throw $err;
        }
      }
      DEF
    end
  end

  def generate(node : Nop)
    ""
  end

  def generate(node : Expressions)
    if node.expressions.empty?
      return ""
    end
    String.build do |str|
      str << generate(node.expressions[0])
      node.expressions[1..-1].each do |e|
        code = generate(e)
        str << ",\n" << code unless code.is_a? String && code.blank?
      end
    end
  end

  def generate(node : While)
    Crustache.render Templates::WHILE, {
      "Condition" => generate(node.cond),
      "Body" => generate(node.body)
    }
  end

  def generate(node : Call)
    if (body = node.target_def.body).is_a? Primitive
      if (obj = node.obj).nil?
        args = node.args
      else
        args = node.args.dup.unshift obj
      end
      return PrimitiveGen.codegen_primitive(body, node.target_def, args)
    end
    owner = node.target_def.owner
    unless (obj=node.obj).nil?
      return Crustache.render Templates::CALL, {
        "Object" => generate(obj),
        "MethodName" => CrystalScript.get_method(nil, node.target_def, is_instance: nil),
        "args" => node.args.map { |arg|
          { "Arg" => generate(arg) }
        },
      }
    else
      if owner == node.scope? && !owner.is_a? MetaclassType && !owner.is_a? VirtualMetaclassType && !owner.is_a? GenericModuleInstanceMetaclassType && !owner.is_a? GenericClassInstanceMetaclassType
        return Crustache.render Templates::CALL, {
          "Object" => "this",
          "MethodName" => CrystalScript.get_method(nil, node.target_def, is_instance: nil),
          "args" => node.args.map { |arg|
            { "Arg" => generate(arg) }
          },
        }
      else
        return Crustache.render Templates::CALL, {
          "Object" => "",
          "MethodName" => CrystalScript.get_method(owner, node.target_def, is_instance: nil),
          "args" => node.args.map { |arg|
            { "Arg" => generate(arg) }
          },
        }
      end
    end
  rescue ex
    if (ex.message.try &.match(/^Zero target defs for/)).nil?
      raise ex
    else
      CrystalScript.logger.warn ex
    end
    return ""
  end

  def generate(node : InstanceVar)
    "this.$instance_vars['#{node.name}']"
  end

  def generate(node : ClassVar)
    unless (var = node.var?).nil?
      type_s = Crustache.render Templates::CLASS, {
        "path" => CrystalScript.to_str_path(var.owner).map { |t|
          {"Type" => t}
        }
      }
      "#{type_s}.$class_vars['#{node.name}']"
    else
      CrystalScript.logger.warn "ClassVar without a var: #{node}"
      ""
    end
  end

  def generate(node : Assign)
    "#{generate(node.target)} = #{generate(node.value)}"
  end

  def generate(node : Var)
    node.name
  end

  def generate(node : UninitializedVar)
    CrystalScript.logger.warn "Uninitialised variable declaration: #{node} in #{node.location}"
    "/* uninitialised variable! */"
  end

  def generate(node : NilLiteral)
    "#{CrystalScript::GLOBAL_CLASS}.nil"
  end

  def generate(node : BoolLiteral)
    node.false? ? "#{CrystalScript::GLOBAL_CLASS}.false" : "#{CrystalScript::GLOBAL_CLASS}.true"
  end

  def generate(node : TupleLiteral)
    Crustache.render Templates::TUPLE_LITERAL, {
      "type_args" => node.elements.map_with_index { |elt, i|
        {
          "Type" => CrystalScript.to_str_path(elt.type?).try(&.join "::"),
          "last" => i == node.elements.size - 1
        }
      },
      "values" => node.elements.map { |elt|
        { "Value" => generate(elt) }
      }
    }
  end

  def generate(node : NumberLiteral)
    Crustache.render Templates::SIMPLE_LITERAL, {
      "Type" => CrystalScript.get_number_class(node.kind),
      "Value" => node.value
    }
  end

  def generate(node : StringLiteral)
    Crustache.render Templates::SIMPLE_LITERAL, {
      "Type" => "String",
      "Value" => "\"#{node.value}\""
    }
  end

  def generate(node : If)
    if node.truthy?
      if (exp = node.then).is_a? Expressions
        exp.expressions.unshift(node.cond)
      else
        generate(Expressions.new [node.cond, node.then])
      end
    elsif node.falsey?
      if (exp = node.else).is_a? Expressions
        exp.expressions.unshift(node.cond)
      else
        generate(Expressions.new [node.cond, node.else])
      end
    else
      <<-IF
      (() => {
        if (#{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::TRUTHY}(#{generate node.cond})) {
          return #{generate node.then};
        } else {
          return #{generate node.else};
        }
      })()
      IF
    end
  end

  def generate(node : Generic)

    if (type = node.type?).is_a? MetaclassType || type.is_a? VirtualMetaclassType || type.is_a? GenericModuleInstanceMetaclassType || type.is_a? GenericClassInstanceMetaclassType
      type = type.try &.instance_type
    end

    Crustache.render Templates::CLASS, {
      "path" => CrystalScript.to_str_path(type).try &.map { |t|
        { "Type" => t }
      }
    }
  end

  def generate(node : Path)
    Crustache.render Templates::CLASS, {
      "path" => CrystalScript.to_str_path(node).map { |t|
        { "Type" => t }
      }
    }
  end

  def generate(node : IsA)
    "(#{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::IS_A}(#{generate node.obj},#{generate node.const}))"
  end

  def generate(node : Return)
    value = (exp = node.exp).nil? ? "#{CrystalScript::GLOBAL_CLASS}.nil" : generate exp
    "(() => { throw new #{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::RETURN_EXCEPTION}(#{value}); })()"
  end

  def generate(node : ExpandableNode)
    CrystalScript.logger.error("Unexpanded ExpandableNode: #{node} (#{node.class})")
    return "undefined /* #{node.class} (ExpandableNode) */"
  end

  def generate(node : Primitive)
    CrystalScript.logger.warn "Unexpected Primitive #{node.name}"
  end

  def generate(node : ASTNode)
    CrystalScript.logger.warn("Unimplemented ASTNode #{node.class}")
    "undefined /* #{node.class} #{node} */"
  end
end
