# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pushwoosh/version'

Gem::Specification.new do |spec|
  spec.name          = "pushwoosh"
  spec.version       = Pushwoosh::VERSION
  spec.authors       = ["Pedro Andrade"]
  spec.email         = ["pedro.rjandrade@gmail.com"]
  spec.description   = %q{Pushwoosh wrapper to remote API}
  spec.summary       = %q{Pushwoosh Remote API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", '~> 10.4.2'
  spec.add_development_dependency 'rspec', "~> 3.1.0"
  spec.add_development_dependency 'vcr', "~> 2.8.0"
  spec.add_development_dependency 'webmock', "~> 1.15.0"
  spec.add_development_dependency 'pry', '0.10.1'
  spec.add_dependency "httparty", "~> 0.14.0"
end
