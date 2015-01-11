# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pushwoosh/version'

Gem::Specification.new do |spec|
  spec.name          = "pushwoosh"
  spec.version       = Pushwoosh::VERSION
  spec.authors       = ["Pedro Andrade"]
  spec.email         = ["pedro.rjandrade@gmail.com"]
  spec.description   = %q{Pushwoosh gem}
  spec.summary       = %q{Pushwoosh Remote API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-expectations'
  spec.add_development_dependency 'rspec-mocks'
  spec.add_development_dependency 'vcr', "~> 2.8.0"
  spec.add_development_dependency 'webmock', "~> 1.15.0"
  spec.add_development_dependency 'pry'
  spec.add_dependency "httparty"
  spec.add_dependency "activesupport"
end
