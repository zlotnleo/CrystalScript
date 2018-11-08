require "./spec_helper"

Tests = [
  {"assignemnts, number and string literals", "simple.cr"}
]

describe CrystalScript do
  describe "#convert" do
    Tests.each do |description, filename|
      it description do
        run_test(filename)
      end
    end
   end
 end
