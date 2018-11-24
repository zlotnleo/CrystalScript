require "compiler/crystal/syntax"
require "./js_helpers/*"
require "./ast_nodes"

module CrystalScript
  def self.convert(crystal_code : String)
    ast = Crystal::Parser.parse(crystal_code)
    js_code = include_js_sources
    js_code += CrystalScript::CodeGen.new.generate(ast)
  end
end

puts(CrystalScript.include_js_sources())
