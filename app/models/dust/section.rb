module Dust
  class Section < ActiveRecord::Base
    belongs_to :page
    attr_accessible :classes, :position, :title
    acts_as_nested_set
    default_scope roots

    validates_presence_of :title
  end
end
