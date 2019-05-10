require "compiler/crystal/**"
require "./codegen/**"
require "./utils/*"

class CrystalScript
  include Crystal
  ENV["CRYSTAL_PATH"] = "#{__DIR__}:#{ENV.fetch("CRYSTAL_PATH", `crystal env CRYSTAL_PATH`)}"

  GLOBAL_CLASS = "Crystal_Program"
  NULL_CLASS = "$NullClass"
  TRUTHY = "$truthy"

  getter program : Program
  getter node : ASTNode

  @no_codegen = true
  @no_cleanup = false
  @prelude = "crs_prelude"

  def initialize(@program, @node)
    @nto = NamedTypeOrderer.new(@program)
  end

  def generate
    code = Crustache.render Templates::INIT_CRYSTALSCRIPT, nil

    # TODO: generate symbol table

    # @nto.visit(@program)

    code += init_named_types
    code += apply_include
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
class Foo(K, V)
end

class Bar(T) < Foo(T, Int32)
end

a = Bar(String).new

puts a.is_a? Bar                 # => true
puts a.is_a? Bar(String)         # => true
puts a.is_a? Bar(Int32)          # => false

puts a.is_a? Foo                 # => true
puts a.is_a? Foo(String, Int32)  # => true
puts a.is_a? Foo(Int32, Int32)   # => false
puts a.is_a? Foo(String, String) # => false

PROGRAM

result = CrystalScript.compile(source)
puts result
