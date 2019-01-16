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
require "./ast_nodes/**"
require "./js_helpers/*"
require "./utils/*"

module CrystalScript
  include Crystal
  ENV["CRYSTAL_PATH"] = "#{__DIR__}:#{ENV.fetch("CRYSTAL_PATH", `crystal env CRYSTAL_PATH`)}"

  class CodeGen
    def generate(node : Def | LibDef | FunDef )
      #placeholder to pass semantic checking
      return ""
    end

    # def generate(node : Def)
    #   # node.annotations : Hash(AnnotationType, Annotation)
    #   # if node.name != "puts"
    #   #   puts <<-DEF
    #   #     Method definition:
    #   #       name: #{node.name}
    #   #       free_vars: #{node.free_vars}
    #   #       receiver: #{node.receiver}
    #   #       args: #{node.args}
    #   #       splat_index: #{node.splat_index}
    #   #       double_splat: #{node.double_splat}
    #   #       body: #{node.body}
    #   #       block_arg: #{node.block_arg}
    #   #       return_type: #{node.return_type}
    #   #       yields: #{node.yields}
    #   #       visibility: #{node.visibility}
    #   #       owner: #{node.owner}
    #   #       original_owner?: #{node.original_owner?}
    #   #       vars: #{node.vars}
    #   #       yield_vars: #{node.yield_vars}
    #   #       previous: #{node.previous}
    #   #       next: #{node.next}
    #   #       special_vars: #{node.special_vars}
    #   #       block_nest: #{node.block_nest}
    #   #       raises?: #{node.raises?}
    #   #       closure?: #{node.closure?}
    #   #       self_closured?: #{node.self_closured?}
    #   #       captured_block?: #{node.captured_block?}
    #   #     DEF
    #   #   end

    #   puts "
    #   name: #{node.name}
    #   owner: #{node.owner}
    #   owner.class: #{node.owner.class}
    #   "

    #   ""
    # end
  end

  def self.compile(sources, output_filename)
    compiler = Crystal::Compiler.new
    compiler.no_codegen = true
    compiler.prelude = "crs_prelude"
    result = compiler.compile(sources, output_filename)

    program = result.program
    ast = result.node

    # puts <<-PROGRAM
    # symbols: #{program.symbols}
    # global_vars: #{program.global_vars}
    # file_modules: #{program.file_modules}
    # vars: #{program.vars}
    # requires: #{program.requires}
    # PROGRAM

    CodeGen.new.generate(result.node)
  end
end

source = Crystal::Compiler::Source.new "source_filename.cr", <<-PROGRAM

PROGRAM

result = CrystalScript.compile(source, "out.js")
puts result
