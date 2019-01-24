require "./spec_helper"

Tests = [
  {"assignemnts, number and string literals", "simple.cr"}
]

# describe "wait_or_timeout" do
#   it "doesn't let the code run forever" do
#     expect_raises(Timeout) do
#       proc = Process.new("crystal", args: ["eval", "while true; end"], error: STDERR)
#       wait_or_timeout(proc, 0.5.seconds)
#     end
#   end
# end

# describe CrystalScript do
#   describe "#convert" do
#     Tests.each do |description, filename|
#       it description do
#         run_test(filename)
#       end
#     end
#    end
#  end

describe CrystalScript do
  it "needs to have some tests that actually test the code" do
    cr_code = <<-CRYSTAL
      a = 10
      puts a.to_s + " apples"
    CRYSTAL

    js_code = <<-JS
      let a = 10;
      console.log(a + " apples");
    JS

    cr_output = `crystal eval \"#{cr_code.gsub("\"", "\\\"")}\"`
    js_output = `node --eval \"#{js_code.gsub("\"", "\\\"")}\"`

    cr_output.should eq js_output
  end
end
