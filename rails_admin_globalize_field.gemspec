# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_admin_globalize_field/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_admin_globalize_field"
  spec.version       = RailsAdminGlobalizeField::VERSION
  spec.authors       = ["Andrew Volozhanin"]
  spec.email         = ["linuxheadrus@gmail.com"]
  spec.description   = %q{Adds tabbed interface and custom field type for globalize translations to Rails_admin}
  spec.summary       = %q{Tabbed interface and custom field type for globalize translations for Rails_admin}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # TODO: test on earlier versions
  spec.add_runtime_dependency "rails", ">= 4.0"
  spec.add_runtime_dependency 'rails_admin', '>= 0.5'

  # TODO: uncomment later, when globalize3 rails4 branch would be commited to rubygems
  spec.add_runtime_dependency 'globalize', '>= 4.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
