require "json"

class PythonError < StandardError ; end

class JSONWithInt
  def self.parse(json)
    begin
      JSON.parse(json)
    rescue JSON::ParserError
      json.to_i
    end
  end
end

module Python
  def self.method_missing(name, *args)
    args = args.to_json
    output =  %x[python -c "import json ; from poop import * ; \
                 args = json.loads('''#{args}''') ; \
                 print json.dumps(#{name}(*args))" 2>&1 |\
                 pygmentize -l pytb]
    if output.include? 'Traceback (most recent call last)'
      puts output
      raise PythonError
    end
    JSONWithInt.parse(output.strip)
  end
end
