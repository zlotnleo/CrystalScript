require "compiler/crystal/**"
require "./codegen"
require "./js_helpers/*"
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

  def self.from_file(filename, output_filename)
    source = Crystal::Compiler::Source.new filename, File.read(filename)
    compile(source, output_filename)
  end
end

source = Crystal::Compiler::Source.new "source_filename.cr", <<-PROGRAM
# class Outer
#   class Inner1
#     def func
#       puts "inner 1"
#     end
#   end
# end

# class Outer::Inner2
#   def func
#     puts "inner2"
#   end
# end

# def Outer.func
#   puts "outer"
# end

# class Outer
#   def self.self_func
#     puts "also outer"
#   end
# end

# class Outer::Inner3 end

# class Outer
#   def Inner3.func
#     puts "inner3"
#   end
# end

# module MyModule
#   def self.module_self_method
#   end

#   def module_included_method
#   end
# end

# class Test
#   @@val = f
#   @@val = 4

#   def self.f
#     this is never compiled
#     @@val
#   end

#   def self.val
#     @@val
#   end
# end

# puts Test.val

# module MyModule
#   def f1
#   end
# end

# class MyClass
#   # include MyModule
#   def f2
#   end
# end

# class MyChildClass < MyClass
#   def f3
#   end
# end

# def some_method(x, y = 1, z = 3)
#   puts "Hello"
# end

a = "Hello"
puts a
b = 23
puts b
a = b + 1
puts a

PROGRAM

result = CrystalScript.compile(source, "out.js")
puts result
