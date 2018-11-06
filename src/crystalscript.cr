require "compiler/crystal/syntax"
require "./types"
require "./method_name"
require "./ast_nodes"

module CrystalScript
  def self.convert(crystal_code : String)
    ast = Crystal::Parser.parse(crystal_code)
    js_code = CrystalScript::AST.new.generate(ast)
  end
end
