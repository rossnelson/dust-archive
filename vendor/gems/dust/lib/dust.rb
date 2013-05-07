require "dust/engine"
require "sorcery"
require "declarative_authorization"
require "client_side_validations"
require "will_paginate"
require "simple_form"
require "country_select"
require "client_side_validations-simple_form"
require "carrierwave"
require "mini_magick"
require "awesome_nested_set"
require "auto_build"

require "hashie"
require "jbuilder"
require "mustache"
require "haml-rails"
require "thin"
require "numbers_and_words"

module Dust
  def self.root
    path = File.join(Rails.root, "vendor", "gems", "dust")
    Pathname.new(path)
  end

  def self.site_wides
    @site_wide ||= Dust::SiteWide.all_to_object
  end
end
