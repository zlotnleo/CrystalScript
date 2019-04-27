require "compiler/crystal/**"
require "./codegen"
require "./utils/*"

class CrystalScript
  include Crystal
  ENV["CRYSTAL_PATH"] = "#{__DIR__}:#{ENV.fetch("CRYSTAL_PATH", `crystal env CRYSTAL_PATH`)}"

  GLOBAL_CLASS = "Crystal_Program"

  getter program : Program
  getter node : ASTNode
  @ntv = NamedTypeVisitor.new

  def initialize(@program, @node)
  end

  def generate
    code = Crustache.render Templates::INIT_GLOBAL_CLASS,  {
      "GlobalClass" => CrystalScript::GLOBAL_CLASS
    }
    code += Crustache.render Templates::CREATE_METHOD_CLASS, {
      "GlobalClass" => CrystalScript::GLOBAL_CLASS,
    }

    # TODO: generate symbol table

    @ntv.accept(@node)
    code += declare_named_types
    code += set_named_types_prototypes

    # code += generate(@node)
    code
  end

  def self.compile(sources, output_filename)
    compiler = Crystal::Compiler.new
    compiler.no_codegen = true
    compiler.prelude = "crs_prelude"
    result = compiler.compile(sources, output_filename)

    CrystalScript.new(result.program, result.node).generate
  end

  def self.from_file(filename, output_filename)
    source = Crystal::Compiler::Source.new filename, File.read(filename)
    compile(source, output_filename)
  end

  # class CodeGen
  #   def generate(node : ModuleDef | ClassDef)
  #     generate(node.body)
  #   end

  #   def generate(node : Path)
  #     "(Path #{node.names})"
  #   end
  # end
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

class Test
  property value

  def self.class_method
    puts "Class"
  end

  def instance_method
    puts "Instance"
  end

  def initialize(@value = 3)
  end
end
PROGRAM

result = CrystalScript.compile(source, "out.js")
puts result
