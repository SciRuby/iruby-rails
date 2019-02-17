# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'iruby/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "iruby-rails"
  spec.version       = Iruby::Rails::VERSION
  spec.authors       = ["Kenta Murata"]
  spec.email         = ["mrkn@mrkn.jp"]

  spec.summary       = %q{IRuby and Rails integration}
  spec.description   = %q{Loading rails environment in iRuby notebook shell}
  spec.homepage      = "https://github.com/mrkn/iruby-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.17.2"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "rails"
  spec.add_dependency "iruby", "~> 0.3"
end
