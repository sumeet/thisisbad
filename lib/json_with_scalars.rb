require "json"

class JSONWithScalars
  def self.parse(json)
    JSON.parse(%Q{[#{json}]}).first
  end
end
