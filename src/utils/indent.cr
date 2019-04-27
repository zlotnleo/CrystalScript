module CrystalScript
  def self.indent(code, *, by = 2, blocks = 1)
    indent = blocks * by
    String.build do |str|
      code.each_line(chomp=false) do |line|
        str << " " * indent << line unless line.blank?
      end
    end
  end
end
