require "pywithrb"

describe "pywithrb" do
  before(:each) do
    File.open("python_module.py", "w") do |f|
      f.write("def add_one(x): return x + 1")
    end
  end

  after(:each) { File.delete("python_module.py") }

  it "raises an error when there's an exception" do
   output = ["Traceback (most recent call last):\e[39;49;00m\n  File ",
             "\e[39;49;00m\e[36m\"<string>\"\e[39;49;00m, line ",
             "\e[39;49;00m\e[34m1\e[39;49;00m, in ",
             "\e[39;49;00m<module>\e[39;49;00m\n\e[31;01mNameError",
             "\e[39;49;00m: \e[39;49;00mname 'idx' is not ",
             "defined\e[39;49;00m\n"].join("")
    STDOUT.should_receive(:puts).with(output)
    expect do
      Python::python_module.idx(123)
    end.to raise_exception(Python::PythonError)
  end

  it "receives output from python" do
    Python::python_module.add_one(123).should == 124
  end
end

