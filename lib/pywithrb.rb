require "json"
require "shell"

class PythonError < StandardError ; end

class JSONWithScalars
  def self.parse(json)
    JSON.parse(%Q{[#{json}]}).first
  end
end


Shell.def_system_command(:pygmentize, "pygmentize -l pytb")


module Python
  def self.method_missing(name, *args)
    args = args.to_json
    output =  %x[python -c 'import json ; from poop import * ; \
                 args = json.loads("""#{args}""") ; \
                 print json.dumps(#{name}(*args))' 2>&1]
    if output.include? "Traceback (most recent call last)"
      process = Shell.new.transact do
        echo(output) | pygmentize
      end
      puts process.to_s
      raise PythonError
    end
    JSONWithScalars.parse(output.strip)
  end
end
