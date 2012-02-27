require "json_with_scalars"

describe JSONWithScalars do
  it "parses regular JSON stuff" do
    JSONWithScalars.parse({"blah" => 123}.to_json).should == {"blah" => 123}
  end

  it "parses scalar ints" do
    JSONWithScalars.parse("123").should == 123
  end

  it "parses scalar strings" do
    JSONWithScalars.parse('"abc"').should == "abc"
  end
end
