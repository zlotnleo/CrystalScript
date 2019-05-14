require "compiler/crystal/**"
require "./codegen/**"
require "./utils/*"

class CrystalScript
  include Crystal
  ENV["CRYSTAL_PATH"] = "#{__DIR__}:#{ENV.fetch("CRYSTAL_PATH", `crystal env CRYSTAL_PATH`)}"

  GLOBAL_CLASS = "Crystal_Program"
  NULL_CLASS = "$NullClass"
  TRUTHY = "$truthy"
  IS_A = "$is_a"

  getter program : Program
  getter node : ASTNode

  @no_codegen = true
  @no_cleanup = false
  @prelude = "crs_prelude"

  def initialize(@program, @node, @output : IO)
    @nto = NamedTypeOrderer.new(@program)
  end

  def generate
    @output << Crustache.render Templates::INIT_CRYSTALSCRIPT, nil

    # TODO: generate symbol table

    init_named_types
    set_instance
    apply_include
    define_instance_methods
    apply_extend
    define_class_methods

    @output << Crustache.render Templates::INIT_LITERALS, nil
  end

  def self.compile(sources, output)
    compiler = Crystal::Compiler.new
    compiler.no_codegen = true
    compiler.no_cleanup = false
    compiler.prelude = "crs_prelude"
    result = compiler.compile(sources, "")
    CrystalScript.new(result.program, result.node, output).generate
  # rescue ex
  #   CrystalScript.logger.fatal ex
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
puts 2 + 4

class SimpleClass
end

class Foo(K, V)
  class SubFoo(T, U) < Foo(T, U)
  end
end

class Bar(T) < Foo((Foo::SubFoo(T, String)|Nil), Int32)

  def method(arg : T)
  end

  def method(arg : Nil)
  end

  def method(x, y = 7, *args)
  end

  def method(arr : Bar)
  end
end

def test
  sc = SimpleClass.new

  a = Bar(String).new

  a.method "Hello"
  a.method nil
  a.method x: 11
  a.method x: "World"
  a.method x: 1, y: 3
  a.method y: 3, x: 1
  a.method 1, 2, 3, 4, 5
  a.method Bar(Int32).new
  a.method Bar(String).new
  a.method Bar(Int32 | String).new
end

test

module M11
  def method1
  end
end

module M12
  def method2
  end
end

module M2
  extend M11
  extend M12
end

class C
  include M11
  include M12
end
C.new.method1
C.new.method2

module GenericModule(T)
  def id_t(t : T)
    t
  end

  def id(u : U) forall U
    u
  end
end

class GenericClass(T)
  include GenericModule(T)
end

def call
  gc = GenericClass(Int32).new
  puts gc.id_t(4)
  puts gc.id(11)
  puts gc.id("world")
end

call

PROGRAM

CrystalScript.compile(source, STDOUT)
