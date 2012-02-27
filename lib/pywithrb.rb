require "shell"

require "json_with_scalars"

class PythonError < StandardError ; end


module Python
  class Module
    def initialize(name)
      @name = name
    end

    def method_missing(python_function_name, *args)
      output = call_python(python_function_name, args.to_json)
      if contains_python_stack_trace?(output)
        puts format_stack_trace(output)
        raise PythonError
      end
      parse_output_to_ruby(output)
    end

    private
    def contains_python_stack_trace?(output)
      output.include? "Traceback (most recent call last)"
    end

    def call_python(python_function_name, args)
      %x[python -c 'import json ; from #{@name} import * ; \
         args = json.loads("""#{args}""") ; \
         print json.dumps(#{python_function_name}(*args))' 2>&1]
    end

    def format_stack_trace(output)
      process = Shell.new.transact do
        echo(output) | pygmentize
      end
      process.to_s
    end

    Shell.def_system_command(:pygmentize, "pygmentize -l pytb")

    def parse_output_to_ruby(output)
      JSONWithScalars.parse(output.strip)
    end
  end

  def self.method_missing(name, *args)
    Module.new(name)
  end
end
