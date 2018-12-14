# require "compiler/crystal/syntax"
# require "./js_helpers/*"
# require "./ast_nodes"

# module CrystalScript
#   def self.convert(crystal_code : String)
#     ast = Crystal::Parser.parse(crystal_code)
#     js_code = include_js_sources
#     js_code += CrystalScript::CodeGen.new.generate(ast)
#   end
# end

ENV["CRYSTAL_PATH"]=__DIR__+":"+`crystal env CRYSTAL_PATH`

require "compiler/crystal/**"

module CrystalScript
  class Compiler < Crystal::Compiler
    @no_codegen = true
    @prelude = "crs_prelude"

    def compile(sources, output_filename)
      result = super
      ast = result.node
    end
  end
end

source = CrystalScript::Compiler::Source.new "", "\
a = 3
puts a
"

CrystalScript::Compiler.new.compile(source, "out.js")
