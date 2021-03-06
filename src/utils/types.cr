class CrystalScript
  def self.get_number_class(kind)
    case kind
    when :i8 then return "Int8"
    when :i16 then return "Int16"
    when :i32 then return "Int32"
    when :i64 then return "Int64"
    when :i128 then return "Int128"
    when :u8 then return "UInt8"
    when :u16 then return "UInt16"
    when :u32 then return "UInt32"
    when :u64 then return "UInt64"
    when :u128 then return "UInt128"
    when :f32 then return "Float32"
    when :f64 then return "Float64"
    else raise ArgumentError.new("Unrecognised number kind #{kind}")
    end
  end
end
