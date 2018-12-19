# require "compiler/crystal/syntax"
# require "./js_helpers/*"

# module CrystalScript
#   def self.convert(crystal_code : String)
#     ast = Crystal::Parser.parse(crystal_code)
#     js_code = include_js_sources
#     js_code += CrystalScript::CodeGen.new.generate(ast)
#   end
# end

require "compiler/crystal/**"
require "./ast_nodes"
require "./js_helpers/*"

module CrystalScript
  include Crystal
  ENV["CRYSTAL_PATH"] = "#{__DIR__}:#{ENV.fetch("CRYSTAL_PATH", `crystal env CRYSTAL_PATH`)}"

  class Compiler < Crystal::Compiler
    @no_codegen = true
    @prelude = "crs_prelude"

    def compile(sources, output_filename)
      result = super
      ast = result.node
      CodeGen.new.generate(ast)
    end
  end
end

source = CrystalScript::Compiler::Source.new "", "\
a = 3
# puts a
"

result = CrystalScript::Compiler.new.compile(source, "out.js")
puts result
