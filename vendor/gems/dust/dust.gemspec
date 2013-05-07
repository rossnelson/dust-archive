# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Maintain your gem's version:
require "dust/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dust"
  s.version     = Dust::VERSION
  s.authors     = ["Ross"]
  s.email       = ["axcess1@me.com"]
  s.homepage    = "simiancreative.com"
  s.summary     = "Summary of Dust."
  s.description = "Description of Dust."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.require_paths = ["lib"]

  s.add_dependency("rails", "~> 3.2.11")
  s.add_dependency("sorcery")
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'

  s.add_dependency "sorcery"
  s.add_dependency "declarative_authorization"

  s.add_dependency "client_side_validations"
  s.add_dependency "will_paginate"
  s.add_dependency 'simple_form'
  s.add_dependency 'country_select'
  s.add_dependency 'client_side_validations-simple_form'

  s.add_dependency "carrierwave"
  s.add_dependency "mini_magick"
  s.add_dependency 'awesome_nested_set'
  s.add_dependency 'auto_build'

  s.add_dependency 'hashie'
  #s.add_dependency 'inherited_resources'
  s.add_dependency 'jbuilder'
  s.add_dependency 'mustache'
  s.add_dependency "haml-rails"
  s.add_dependency "thin"

  s.add_dependency 'numbers_and_words'

  s.add_dependency "better_errors"
  s.add_dependency 'binding_of_caller'
  s.add_dependency 'quiet_assets'
end


