require 'pywithrb'

describe "pywithrb" do
  before(:each) do
    File.open("poop.py", "w") { |f| f.write("def id(x): return x") }
  end

  after(:all) do
    File.delete("poop.py")
  end

  it "raises an error when there's an exception" do
    # XXX: Does not check to see if anything is printed.
    expect { Python::idx(123) }.to raise_exception(PythonError)
  end

  it "does not raise an error when there's no exception" do
    Python::id(123).should == 1234
  end
end

describe JSONWithInt do
  it "parses regular JSON stuff" do
    JSONWithInt.parse({"blah" => 123}.to_json).should == {"blah" => 123}
  end

  it "parses ints" do
    JSONWithInt.parse("123").should == 123
  end
end
