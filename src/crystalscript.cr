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
  SIMPLE_LITERAL = "$literal"
  RETURN_EXCEPTION = "$return"

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
    apply_extend

    @output << Crustache.render Templates::INIT_LITERALS, nil

    @output << "\n#{CrystalScript::GLOBAL_CLASS}['main']['main()']();"
  end

  def self.compile(source : Crystal::Compiler::Source, output)
    compiler = Crystal::Compiler.new
    compiler.no_codegen = true
    compiler.no_cleanup = false
    compiler.prelude = "crs_prelude"
    source = Crystal::Compiler::Source.new source.filename, (source.code + "\n main")
    result = compiler.compile(source, "")
    CrystalScript.new(result.program, result.node, output).generate
  rescue ex
    CrystalScript.logger.fatal ex
  end

  def self.from_file(filename, output)
    source = Crystal::Compiler::Source.new filename, File.read(filename)
    compile(source, output)
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

CrystalScript.from_file(ARGV[0], STDOUT)
