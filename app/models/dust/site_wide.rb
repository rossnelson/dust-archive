module Dust
  class SiteWide < ActiveRecord::Base
    attr_accessible :name, :value, :category

    validates_presence_of :name, :value, :category

    def self.variables_by_category
      items = order('category, name').all
      items.group_by{ |i| i.category }
    end

    def self.default_categories
      ['Site Info', 'Contact Info', 'Location Info']
    end

  end
end
