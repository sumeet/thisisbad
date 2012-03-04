require "shell"

require "json_with_scalars"

Shell.def_system_command(:pygmentize, "pygmentize -l pytb")

module Python
  class Module
    def initialize(name)
      @name = name
    end

    def method_missing(python_function_name, *args)
      output = call_python(python_function_name, args.to_json)
      if contains_python_stack_trace?(output)
        puts colorize_stack_trace(output)
        raise PythonError
      end
      convert_to_ruby(output)
    end

    private
    def call_python(python_function_name, args)
      %x[python -c 'import json ; \
                    from #{@name} import * ; \
                    args = json.loads("""#{args}""") ; \
                    print json.dumps(#{python_function_name}(*args))' \
                    2>&1].strip
    end

    def contains_python_stack_trace?(output)
      output.include? "Traceback (most recent call last)"
    end

    def colorize_stack_trace(output)
      Shell.new.transact { echo(output) | pygmentize }.to_s
    end

    def convert_to_ruby(output)
      JSONWithScalars.parse(output)
    end
  end

  def self.method_missing(name, *)
    Module.new(name)
  end

  class PythonError < StandardError ; end
end
