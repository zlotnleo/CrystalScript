module CrystalScript
  def self.include_js_sources
    code = ""
    dir = __DIR__ + "/../js/"
    Dir.each_child(dir) do |child|
      filename = dir + child
      code += File.read(filename)
    end
    return code
  end
end
