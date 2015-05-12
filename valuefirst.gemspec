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
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = "Ruby gem to communicate with valuefirst sms service provider."
  spec.description   = "Ruby gem to communicate with valuefirst sms service provider."
  spec.homepage      = "http://github.com/spidergears/valuefirst"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "nokogiri-happymapper"
  spec.add_development_dependency "libxml-ruby"
  spec.add_development_dependency "coveralls"
end
