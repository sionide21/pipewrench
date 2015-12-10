# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pipewrench/version'

Gem::Specification.new do |spec|
  spec.name          = "pipewrench"
  spec.version       = Pipewrench::VERSION
  spec.authors       = ["Ben Olive"]
  spec.email         = ["sionide21@gmail.com"]

  spec.summary       = %q{General purpose command line pipe processing tool.}
  spec.homepage      = "https://github.com/sionide21/pipewrench"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
