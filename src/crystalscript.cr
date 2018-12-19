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

  class CodeGen
    def generate(node : Annotation | Def | ClassDef | LibDef | FunDef)
      #placeholder to pass semantic checking of prelude
      return ""
    end
  end

  class Compiler < Crystal::Compiler
    @no_codegen = true
    @prelude = "crs_prelude"

    def compile(sources, output_filename)
      begin
        result = super
      rescue e : TypeException
        puts e
        exit(1)
      end
      ast = result.node
      # puts ast
      CodeGen.new.generate(ast)
    end
  end
end

source = CrystalScript::Compiler::Source.new "", "\
while true
  puts \"Loop\"
  break
end
"

result = CrystalScript::Compiler.new.compile(source, "out.js")
puts result
