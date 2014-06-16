# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'custom_fragment_cache/version'
require 'active_support/concern'
require 'active_support/cache'
require 'custom_fragment_cache/logic'
require 'custom_fragment_cache/fragment'
require 'custom_fragment_cache/configuration'

Gem::Specification.new do |spec|
  spec.name          = "custom_fragment_cache"
  spec.version       = CustomFragmentCache::VERSION
  spec.authors       = ["Yarin Goldman"]
  spec.email         = ["yarin@gettaxi.com"]
  spec.summary       = %q{Define your custom fragment caches}
  spec.description   = %q{Define your custom fragment caches}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activesupport', '>= 3.0'
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
