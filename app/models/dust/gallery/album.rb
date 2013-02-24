module Dust
  module Gallery
    class Album < ActiveRecord::Base
      attr_accessible :description, :position, :title, :active
      acts_as_nested_set

      validates_presence_of :title, :description

      has_many :photos, :dependent => :destroy
    end
  end
end
