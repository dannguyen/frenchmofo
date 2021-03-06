# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'frenchmofo/version'

Gem::Specification.new do |spec|
  spec.name          = "frenchmofo"
  spec.version       = Frenchmofo::VERSION
  spec.authors       = ["Dan Nguyen"]
  spec.email         = ["dansonguyen@gmail.com"]
  spec.description   = %q{A tool for French}
  spec.summary       = %q{Language fun}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  
  spec.add_dependency "hashie"
  spec.add_dependency "thor"
end
