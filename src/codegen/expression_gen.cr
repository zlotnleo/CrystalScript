class CrystalScript::ExpressionGen
  class UnsafeMethodError < Exception
  end

  @local_vars = ["self"] of String
  @in_conditional = false

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
      return (@in_conditional ? "" : "let ") + node.name
    end
    node.name
  end

  def generate(node : UninitializedVar)
    raise UnsafeMethodError.new("Uninitialised variable declaration: #{node} in #{node.location}")
  end

  def generate(node : NilLiteral)
    "#{CrystalScript::GLOBAL_CLASS}.nil"
  end

  def generate(node : BoolLiteral)
    node.false? ? "#{CrystalScript::GLOBAL_CLASS}.false" : "#{CrystalScript::GLOBAL_CLASS}.true"
  end

  def generate(node : If)
    cvv = ConditionalVarVisitor.new
    cvv.accept(node.cond)
    declare = cvv.vars.empty? ? "" : String.build do |str|
      str << "let "
      cvv.vars[0...-1].each do |var|
        str << var << ", "
      end
      str << cvv.vars[-1] << ";\n"
    end

    @in_conditional = true

    if node.ternary?
      result = declare + <<-IF
      (#{generate(node.cond)}) ? (
      #{generate(node.then)}
      ) : (
      #{generate(node.else)}
      )
      IF
    else
      result = declare + <<-IF
      if (#{generate(node.cond)}) {
      #{generate(node.then)}
      } else {
      #{generate(node.else)}
      }
      IF
    end

    @in_conditional = false
    return result
  end

  def generate(node : Path)
    CrystalScript.to_js_name(node)
  end

  def generate(node : IsA)
    "(#{generate node.obj} instanceof #{generate node.const})"
  end

  def generate(node : Return)
    return "" if (exp = node.exp).nil?
    "return #{generate exp}"
  end

  def generate(node : ExpandableNode)
    CrystalScript.logger.error("Unexpanded ExpandableNode: #{node} (#{node.class})")
    return "undefined /* #{node.class} (ExpandableNode) */"
  end

  def generate(node : ASTNode)
    CrystalScript.logger.warn("Unimplemented ASTNode #{node.class}")
    "undefined /* #{node.class} #{node} */"
  end

  private class ConditionalVarVisitor < Crystal::Visitor
    getter vars = [] of String
    def visit(node : Var)
      @vars << node.name if @vars.find &.==(node.name).nil?
    end
    def visit(node : ASTNode)
      node.accept_children(self)
    end

  end
end
