
module Dust
  class Menu
    module ItemDependency
      extend ActiveSupport::Concern

      included do
        attr_accessible :filename, :nav_link, :active
        has_one :menu_item, :as => :linkable, :dependent => :destroy, :autosave => true
        delegate :active, :to => :menu_item
      end

      def match_path
        menu_item.url
      end

      def filename
        self.menu_item.url.gsub("/", "")
      end

      def filename=(filename)
        self.menu_item.url = "/#{filename}"
      end

      def nav_link
        self.menu_item.title
      end

      def nav_link=(filename)
        self.menu_item.title = filename
      end

      module ClassMethods
        def find_by_filename(filename)
          filename = "/#{filename}"
          where(:menu_items => {:url => filename}).joins(:menu_item).first
        end
      end

    end
  end
end
