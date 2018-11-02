require "./spec_helper"

describe CrystalScript do
  describe "#convert" do
    it "handles multiple expressions and number literals" do
      source = "\
1_u8
2_u32; 3.1415_f64; 2.71828_f32
-2
"
      target = "\
new UInt8(\"1\");
new UInt32(\"2\");
new Float64(\"3.1415\");
new Float32(\"2.71828\");
new Int32(\"-2\");
"
      CrystalScript.convert(source).should eq target;
    end

    it "handles assignment of number literals to one variable at a time" do
      source = "\
a = 3_i32
b = 4
a = 12
"
      target = "\
let a = new Int32(\"3\");
let b = new Int32(\"4\");
a = new Int32(\"12\");
"
      CrystalScript.convert(source).should eq target;
    end
  end
end
