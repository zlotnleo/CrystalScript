require "compiler/crystal/syntax"
require "./types"
require "./method_name"
require "./ast_nodes"

module CrystalScript
  def self.convert(crystal_code : String)
    ast = Crystal::Parser.parse(crystal_code)
    js_code = ""
    ["puts", "numbers", "string"].each do |base_name|
      filename = __DIR__ + "/js/" + base_name + ".js"
      js_code += File.read(filename)
    end
    js_code += CrystalScript::CodeGen.new.generate(ast)
  end
end
