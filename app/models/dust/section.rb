module Dust
  class Section < ActiveRecord::Base
    belongs_to :page
    attr_accessible :classes, :position, :title
  end
end
