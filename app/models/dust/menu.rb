module Dust
  class Menu < ActiveRecord::Base
    attr_accessible :desc, :title, :nestable

    has_many :menu_items, :dependent => :destroy
  end
end
