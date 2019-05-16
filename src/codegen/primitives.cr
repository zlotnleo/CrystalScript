module CrystalScript::PrimitiveGen
  extend self

  def codegen_primitive(node, target_def, call_args)
    case node.name
    when "binary"
      codegen_primitive_binary node, target_def, call_args
    when "io"
      codegen_primitive_io node, target_def, call_args
    when "allocate"
      codegen_primitive_allocate node, target_def, call_args
    else
      CrystalScript.logger.error "Unhandled primitive in codegen #{node.name}"
      ""
    end
  end

  def codegen_primitive_binary(node, target_def, call_args)
    p1, p2 = call_args
    t1, t2 = target_def.owner, target_def.args[0].type
    codegen_binary_op target_def.name, t1, t2, p1, p2
  end

  def codegen_binary_op(op, t1 : IntegerType, t2 : IntegerType, p1, p2)
    js_p1 = ExpressionGen.new.generate(p1);
    js_p2 = ExpressionGen.new.generate(p2);

    case op
    when "<"  then return "((#{js_p1}).$value < (#{js_p2}).$value ? #{CrystalScript::GLOBAL_CLASS}.true : #{CrystalScript::GLOBAL_CLASS}.false)"
    when "+"  then return "#{CrystalScript::GLOBAL_CLASS}.#{CrystalScript::SIMPLE_LITERAL}(#{CrystalScript::GLOBAL_CLASS}['Int32'], (#{js_p1}).$value + (#{js_p2}).$value)"
    else  CrystalScript.logger.error "Unimplemented #{t1} #{op} #{t2}"
    end
  end

  def codegen_binary_op(op, t1, t2, p1, p2)
    CrystalScript.logger.error "Unimplemented #{t1} #{op} #{t2}"
    ""
  end

  def codegen_primitive_io(node, target_def, call_args)
    args = call_args.map { |arg| ExpressionGen.new.generate(arg) }
    "(() => {
      console.log(#{args.join(",")});
      return #{CrystalScript::GLOBAL_CLASS}.nil;
    })()"
  end

  def codegen_primitive_allocate(node, target_def, call_args)
    type = target_def.owner.instance_type
    name = CrystalScript.to_str_path(type).map { |t| "['#{t}']" }.join("")
    "new #{CrystalScript::GLOBAL_CLASS}#{name}()"
  end
end
