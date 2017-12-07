
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'poe_filter_generator/version'

Gem::Specification.new do |spec|
  spec.name          = "poe_filter_generator"
  spec.version       = PoeFilterGenerator::VERSION
  spec.authors       = ["isuke"]
  spec.email         = ["isuke770@gmail.com"]

  spec.summary       = %q(Generate "Path Of Exile"'s filter.)
  spec.description   = %q(Generate "Path Of Exile"'s filter.)
  spec.homepage      = "https://github.com/isuke/poe_filter_generator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "> 3.0"
  spec.add_dependency 'thor', '~> 0.19'
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.51"
end
