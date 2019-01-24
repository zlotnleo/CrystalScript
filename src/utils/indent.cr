module CrystalScript
  def self.indent(code, indent=4)
    String.build do |str|
      code.each_line(chomp=false) do |line|
        str << " " * indent << line unless line.blank?
      end
    end
  end
end
