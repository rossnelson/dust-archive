module Dust
  class SiteWide < ActiveRecord::Base
    attr_accessible :name, :value, :category

    validates_presence_of :name, :value, :category

    def self.variables_by_category
      items = order('category, name').all
      items.group_by{ |i| i.category }
    end

    def self.all_to_object
      vars = OpenStruct.new
      variables_by_category.each do |cat, vars_for_cat|
        cat = create_category_method(cat, vars)
        create_vars_for_category_method(cat, vars_for_cat)
      end
      vars
    end

    def self.default_categories
      ['Site Info', 'Contact Info', 'Location Info']
    end

    private

    def self.create_category_method(cat, vars)
      cat = cat.parameterize.gsub("-", "_")
      vars.class.send(:define_method, cat, proc{OpenStruct.new})
      vars.send(cat)
    end

    def self.create_vars_for_category_method(cat, vars)
      vars.each do |var|
        cat.class.send(:define_method, var.name, proc{var.value})
      end
    end

  end
end
