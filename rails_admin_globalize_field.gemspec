# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_admin_globalize_field/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_admin_globalize_field"
  spec.version       = RailsAdminGlobalizeField::VERSION
  spec.authors       = ["Andrew Volozhanin", "Navid Emad"]
  spec.email         = ["scarfacedeb@gmail.com"]
  spec.description   = %q{Adds tabbed interface and custom field type for globalize translations to Rails_admin}
  spec.summary       = %q{Tabbed interface and custom field type for globalize translations for Rails_admin}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 4.2"
  spec.add_dependency 'rails_admin', '>= 0.6.2'

  spec.add_dependency 'globalize', '>= 5.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'rspec-rails', '~> 3.0'
  spec.add_development_dependency 'capybara', '~> 2.4'
  spec.add_development_dependency 'poltergeist', '~> 1.5'
end
