require "compiler/crystal/syntax"
require "./ast_nodes"

s = "3"
ast = Crystal::Parser.parse(s)
puts typeof(->CrystalScript::AST.generate(Crystal::ASTNode))
result = CrystalScript::AST.generate(ast).to_s
puts result
