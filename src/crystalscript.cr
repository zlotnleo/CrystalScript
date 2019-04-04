require "compiler/crystal/**"
require "./codegen"
require "./utils/*"

module CrystalScript
  include Crystal
  ENV["CRYSTAL_PATH"] = "#{__DIR__}:#{ENV.fetch("CRYSTAL_PATH", `crystal env CRYSTAL_PATH`)}"

  class CodeGen
    def generate(node : ModuleDef | ClassDef)
      generate(node.body)
    end

    def generate(node : Path)
      "(Path #{node.names})"
    end
  end

  def self.compile(sources, output_filename)
    compiler = Crystal::Compiler.new
    compiler.no_codegen = true
    compiler.prelude = "crs_prelude"
    result = compiler.compile(sources, output_filename)

    code_gen = CodeGen.new(result.program, result.node)
    code_gen.generate
  end

  def self.from_file(filename, output_filename)
    source = Crystal::Compiler::Source.new filename, File.read(filename)
    compile(source, output_filename)
  end
end

source = Crystal::Compiler::Source.new "source_filename.cr", <<-PROGRAM
module Action
    module Move
        def move()
            puts "move"
        end
    end

    module TakeOff
        def takeoff()
            puts "takeoff"
        end
    end
end

abstract class Vehicle
    include Action::Move
    abstract def ready
    def describe
        "I'm a vehicle"
    end
end

class Plane < Vehicle
    include Action::TakeOff

    # property boarding_complete = false
    @boarding_complete = false
    def boarding_complete
      @boarding_complete
    end
    def boarding_complete=(boarding_complete)
      @boarding_complete = boarding_complete
    end

    def ready
        boarding_complete
    end

    def describe
        "I'm a plane"
    end
end
PROGRAM

result = CrystalScript.compile(source, "out.js")
puts result
