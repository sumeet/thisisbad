$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "thisisbad"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Sumeet Agarwal"]
  s.email       = ["sumeet.a@gmail.com"]
  s.homepage    = "http://github.com/sumeet/thisisbad"
  s.summary     = %q{if you ever want to pretend python could have rspec}
  s.description = %q{if you ever want to pretend python could have rspec}

  s.rubyforge_project = "thisisbad"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
