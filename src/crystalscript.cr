require "compiler/crystal/**"
require "./codegen/**"
require "./utils/*"

class CrystalScript
  include Crystal
  ENV["CRYSTAL_PATH"] = "#{__DIR__}:#{ENV.fetch("CRYSTAL_PATH", `crystal env CRYSTAL_PATH`)}"

  GLOBAL_CLASS = "Crystal_Program"
  METHOD_CLASS = "$Method"
  NULL_CLASS = "$NullClass"
  TRUTHY = "$truthy"

  getter program : Program
  getter node : ASTNode
  @nto = NamedTypeOrderer.new

  @no_codegen = true
  @no_cleanup = false
  @prelude = "crs_prelude"

  def initialize(@program, @node)
  end

  def generate
    code = Crustache.render Templates::INIT_CRYSTALSCRIPT, nil

    # TODO: generate symbol table

    @nto.visit(@program)
    @nto.types.each do |type|
      if type.is_a? GenericType
        CrystalScript.logger.info "#{type}: #{type.inherited}"
      elsif type.is_a? GenericInstanceType
        CrystalScript.logger.info "#{type}: #{type.generic_type.inherited}"
      end
    end

    code += init_named_types
    # code += apply_include
    # code += apply_extend

    code += Crustache.render Templates::INIT_LITERALS, nil

    # code += generate(@node)
    code
  end

  def self.compile(sources)
    compiler = Crystal::Compiler.new
    compiler.no_codegen = true
    compiler.no_cleanup = false
    compiler.prelude = "crs_prelude"
    result = compiler.compile(sources, "out.js")
    CrystalScript.new(result.program, result.node).generate
  end

  def self.from_file(filename, output_filename)
    source = Crystal::Compiler::Source.new filename, File.read(filename)
    compile(source, output_filename)
  end

  class CodeGen
    def generate(node : ModuleDef | ClassDef)
      generate(node.body)
    end

    def generate(node : Path)
      "(Path #{node.names})"
    end
  end
end

source = Crystal::Compiler::Source.new "source_filename.cr", <<-PROGRAM
module Action
    module Move
        def move()
            "move"
        end
    end

    module TakeOff
        def takeoff()
            "takeoff"
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

module Test
  extend Action::Move
end

module Mod
  extend self

  def method
    "instance"
  end

  def self.method
    "module"
  end
end

class ExpandTest
  def m
    a, b = 3, 4
    c = 5 && 8
    "str"
  end
end

ExpandTest.new.m

class NamedStuff
  def test(a, b)
  end
end

ns = NamedStuff.new
ns.test 1, 2
ns.test 1, b: 2
ns.test a: 1, b: 2
ns.test b: 2, a: 1

def at_top_level
end
at_top_level

PROGRAM

result = CrystalScript.compile(source)
puts result
