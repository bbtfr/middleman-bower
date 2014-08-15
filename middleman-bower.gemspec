# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "middleman-bower"
  s.version     = "0.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["bbtfr"]
  s.email       = ["bbtfrr@gmail.com"]
  s.homepage    = "https://github.com/bbtfr/middleman-bower"
  s.summary     = %q{Bundler-like DSL + thor tasks for Bower on Middleman}
  s.description = %q{Bundler-like DSL + thor tasks for Bower on Middleman}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 3.0.0"])
  
  # Additional dependencies
  s.add_runtime_dependency("bower-rails", "~> 0.8.3")
end
