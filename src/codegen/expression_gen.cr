class CrystalScript::ExpressionGen
  class UnsafeMethodError < Exception
  end

  @local_vars = ["self"] of String

  def initialize
  end

  def initialize(func_args)
    @local_vars += func_args
  end

  def generate(node : Nop)
    ""
  end

  def generate(node : Expressions)
    if node.expressions.empty?
      return ""
    end
    String.build do |str|
      node.expressions[0...-1].each do |e|
        str << generate(e) << ";\n"
      end
      str << generate(node.expressions[-1]) << "\n"
    end
  end

  def generate(node : Call)
    unless (obj=node.obj).nil?
      model = {
        "Object" => generate(obj),
        "MethodName" => node.name,
        "HasBlock" => node.block.nil? ? "false" : "true",
        "args" => node.args.map do |arg| {
          "Value" => generate(arg)
        } end,
        "named_args" => node.named_args.try &.map do |narg| {
          "Value" => generate(narg.value),
          "Name" => narg.name
        } end
      }
      return Crustache.render Templates::CALL, model
    else
      "undefined /* TODO: obj-less call */"
    end
  end

  def generate(node : InstanceVar)
    "self.$instance_vars['#{node.name}']"
  end

  def generate(node : Assign)
    "#{generate(node.target)} = #{generate(node.value)}"
  end

  def generate(node : Var)
    if (@local_vars.find &.== node.name).nil?
      @local_vars << node.name
      return "let #{node.name}"
    end
    node.name
  end

  def generate(node : UninitializedVar)
    raise UnsafeMethodError.new("Uninitialised variable declaration: #{node} in #{node.location}")
  end

  def generate(node : ASTNode)
    CrystalScript.logger.warn("Unimplemented ASTNode #{node.class}")
    "undefined /* #{node.class} #{node} */"
  end
end
