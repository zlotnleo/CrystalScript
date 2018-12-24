module CrystalScript
  class CodeGen
    def generate(node : FileNode)
      @local_variables_scope.unshift([] of String)
      code = <<-FILENODE
      {
      #{CrystalScript.indent(generate(node.node))}
      }
      FILENODE
      @local_variables_scope.shift
      return code
    end
  end
end
