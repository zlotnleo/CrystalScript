require "compiler/crystal/**"
require "./codegen"
require "./js_helpers/*"
require "./utils/*"

module CrystalScript
  include Crystal
  ENV["CRYSTAL_PATH"] = "#{__DIR__}:#{ENV.fetch("CRYSTAL_PATH", `crystal env CRYSTAL_PATH`)}"

  class CodeGen
    def generate(node : LibDef | FunDef | ModuleDef | ClassDef)
      #placeholder
      return ""
    end

    def generate(node : Def)
      # Ignore primitive annotation
      return "" if (a = node.annotations) && a[@program.primitive_annotation]?
      "to-be-defined(name: #{node.name}, owner: #{node.owner})"
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

    # puts <<-PROGRAM
    # symbols: #{program.symbols}
    # global_vars: #{program.global_vars}
    # file_modules: #{program.file_modules}
    # vars: #{program.vars}
    # requires: #{program.requires}
    # PROGRAM

    code_gen = CodeGen.new(result.program, result.node)
    code_gen.generate
  end
end

source = Crystal::Compiler::Source.new "source_filename.cr", <<-PROGRAM
# module LocGlob
#   def self.f
#     puts "outside MyModule"
#   end
# end

# module MyModule
#   module LocGlob
#     def self.f
#       puts "inside MyModule"
#     end
#   end

#   def self.call_local
#     LocGlob.f
#   end

#   def self.call_global
#     ::LocGlob.f
#   end
# end

# module CompletelyUnrelated
#     module MyModule::Nested
#         def self.some_func
#             puts "called!"
#         end

#         def not_self_func
#         end
#     end
# end

# module M1::M2::M3::M4
# end

# class NonExistentModule::Class
# end

# module M1::AnotherModule
# end

# module M1::M2::YetAnotherModule
# end

module GenericModule(T)
    module InsideGeneric
        def self.func
            puts "output"
        end

        def self.t
            puts T
        end
    end
    def self.func
        puts T
    end
end

PROGRAM

result = CrystalScript.compile(source, "out.js")
puts result
