module CrystalScript
  def self.ast_to_s(node : Nil)
    "<Nil>"
  end
  def self.ast_to_s(node : Nop)
    "Nop"
  end
  def self.ast_to_s(node : Expressions)
    String.build do |str|
      str << "Expressions\n"
      node.expressions.each do |exp|
        str << indent(ast_to_s(exp))
      end
    end
  end
  def self.ast_to_s(node : FileNode)
    "FileNode (#{node.filename})\n" + indent(ast_to_s(node.node))
  end
  def self.ast_to_s(node : Assign)
    <<-ASSIGN
    Assign
      target:
    #{indent(ast_to_s(node.target))}
      value:
    #{indent(ast_to_s(node.value))}\n
    ASSIGN
  end
  def self.ast_to_s(node : Var)
    "Var #{node.name}"
  end
  def self.ast_to_s(node : NumberLiteral)
    "NumberLiteral #{node.value}:#{node.kind}"
  end
  def self.ast_to_s(node : NilLiteral)
    "NilLiteral"
  end
  def self.ast_to_s(node : BoolLiteral)
    "BoolLiteral #{node.value}"
  end
  def self.ast_to_s(node : StringLiteral)
    "StringLiteral #{node.value}"
  end
  def self.ast_to_s(node : Def)
    <<-DEF
    Def
      receiver
    #{indent(ast_to_s(node.receiver))}
      args
    #{if node.args.empty?
        indent("[]")
      else
        String.build do |str|
          node.args.each do |arg|
            str << indent(ast_to_s(arg)) << "\n"
          end
        end
      end}
      double_splat
    #{indent(ast_to_s(node.double_splat))}
      block_arg
    #{indent(ast_to_s(node.block_arg))}
      return_type
    #{indent(ast_to_s(node.return_type))}
      body
    #{indent(ast_to_s(node.body))}
    DEF
  end
  def self.ast_to_s(node : Call)
    nargs = node.named_args
    <<-CALL
    Call
      obj
    #{indent(ast_to_s(node.obj))}
      args
    #{String.build do |str|
        node.args.each do |arg|
          str << indent(ast_to_s(arg)) << "\n"
        end
      end}
      block
    #{indent(ast_to_s(node.block))}
      block_arg
    #{indent(ast_to_s(node.block_arg))}
      named_args
    #{if nargs.nil?
        indent("<Nil>")
      else
        String.build do |str|
          nargs.each do |arg|
            str << indent(ast_to_s(arg)) << "\n"
          end
        end
      end}
    CALL
  end
  def self.ast_to_s(node : Arg)
    <<-ARG
    Arg (#{node.name})
      default_value
    #{indent(ast_to_s(node.default_value))}
      restriction
    #{indent(ast_to_s(node.restriction))}\b
    ARG
  end
  def self.ast_to_s(node : ClassDef)\
    <<-CLASSDEF
    ClassDef (#{ast_to_s(node.name)})
      superclass
    #{indent(ast_to_s(node.superclass))}
      body
    #{indent(ast_to_s(node.body))}\n
    CLASSDEF
  end
  def self.ast_to_s(node : Path)
    # "Path (#{String.build { |str| node.names.each { |name| str << name << ", "} }})"
    "Path (#{node.names})"
  end
  def self.ast_to_s(node : InstanceVar)
    "InstanceVar (#{node.name})"
  end
  def self.ast_to_s(node : ModuleDef)
    <<-MODULEDEF
    ModuleDef (#{ast_to_s(node.name)})
      body
    #{indent(ast_to_s(node.body))}\n
    MODULEDEF
  end
  def self.ast_to_s(node : ControlExpression)
    "#{node.class}\n#{indent(ast_to_s(node.exp))}"
  end
  def self.ast_to_s(node : Union)
    <<-UNION
    Union
    #{if node.types.empty?
        indent("[]")
      else
        String.build do |str|
          node.types.each do |type|
            str << indent(ast_to_s(type)) << "\n"
          end
        end
      end}
    UNION
  end
  def self.ast_to_s(node : CharLiteral)
    "CharLiteral #{node.value}"
  end

  def self.ast_to_s(node : ASTNode)
    "ASTNode #{node.class}\n  ???\n"
  end
end
