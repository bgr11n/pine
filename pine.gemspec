# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pine/version'

Gem::Specification.new do |spec|
  spec.name          = "pine"
  spec.version       = Pine::VERSION
  spec.authors       = ["bgr11n"]
  spec.email         = ["bgr11n@gmail.com"]
  spec.summary       = %q{Pine.}
  spec.description   = %q{Pine.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency             "better_errors",  "~> 2.1.1"
  spec.add_dependency             "actionpack",     "~> 4.1.6"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake"
end
