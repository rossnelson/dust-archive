module Dust
  class Menu < ActiveRecord::Base
    attr_accessible :desc, :title, :nestable

    has_many :menu_items, :dependent => :destroy

    def active_items
      menu_items.roots.where(:active => true)
    end
  end
end
