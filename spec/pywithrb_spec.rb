require 'pywithrb'

describe "pywithrb" do
  before(:each) do
    File.open("poop.py", "w") { |f| f.write("def id(x): return x") }
  end

  after(:each) { File.delete("poop.py") }

  it "raises an error when there's an exception" do
   output = ["Traceback (most recent call last):\e[39;49;00m\n  File ",
             "\e[39;49;00m\e[36m\"<string>\"\e[39;49;00m, line ",
             "\e[39;49;00m\e[34m1\e[39;49;00m, in ",
             "\e[39;49;00m<module>\e[39;49;00m\n\e[31;01mNameError",
             "\e[39;49;00m: \e[39;49;00mname 'idx' is not ",
             "defined\e[39;49;00m\n"].join("")
    STDOUT.should_receive(:puts).with(output)
    expect { Python::idx(123) }.to raise_exception(PythonError)
  end

  it "does not raise an error when there's no exception" do
    Python::id(123).should == 123
  end

  it "still need to generalize to load any module"
end

