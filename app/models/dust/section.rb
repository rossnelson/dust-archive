module Dust
  class Section < ActiveRecord::Base
    belongs_to :page
    attr_accessible :classes, :position, :title

    validates_presence_of :title, :classes
    validates_uniqueness_of :title, :classes
  end
end
