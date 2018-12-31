# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'valuefirst/version'

Gem::Specification.new do |spec|
  spec.name          = "valuefirst"
  spec.version       = Valuefirst::VERSION
  spec.authors       = ["spidergears"]
  spec.email         = ["findspidergears@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  end

  spec.summary       = "Ruby gem to communicate with valuefirst sms service provider."
  spec.description   = "Ruby gem to communicate with valuefirst sms service provider."
  spec.homepage      = "http://github.com/spidergears/valuefirst"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri-happymapper", "~> 0.4"
  spec.add_dependency "libxml-ruby", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-rails", "~> 3.2"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-nav", "~> 0.2.4"
  spec.add_development_dependency "coveralls", "~> 0.8"
end
