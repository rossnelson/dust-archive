module Dust
  class Page < ActiveRecord::Base
    attr_accessible :active, :partial_name, :meta_title, :filename, :nav_link, :heading, :keywords, :description, :classes

    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::SanitizeHelper

    validates_presence_of :nav_link
    validates_presence_of :meta_title
    validates_presence_of :filename
    validates_uniqueness_of :filename
    #validates_uniqueness_of :partial_name, :if => Proc.new{|instance| !instance.partial_name.blank?}
    
    def match_path
      return "/#{self.filename}"
    end
    
    #-- ActiveRecord Queries --#
    def self.page(search, page)
      with_permissions_to(:manage).search(search).order("title").paginate(:per_page => 12, :page => page)
    end

    def self.search(search)
      if search
        where("nav_link LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")
      else
        scoped
      end
    end

    def front_end_content
      options = {
        :page => self
      }

      Handlebar.render(content, options)
    end

    #-- Page Specific Keywords/Description --#
    def create_keywords
      if keywords.blank?
        ""
      else
        modified = keywords.gsub(/[^0-9A-Za-z]/, ' ')
        mod_array = modified.split(" ")
        mod_array.join(", ")
      end
    end

    def create_description
      meta_description
    end

    #-- Menu Item Creation --#
    has_one :menu_item, :as => :linkable, :dependent => :destroy

    after_create :create_menu_item, :create_starter_block
    after_update :update_menu_item

    def update_menu_item
      @menu_item = self.menu_item
      if @menu_item == nil
        self.create_menu_item
      else
        @menu_item.update_attributes(
          :title => self.nav_link,
          :url => self.match_path,
          :active => self.active
        )
      end
    end

    def create_menu_item
      @menu_item = self.build_menu_item(
        :title => self.nav_link,
        :url => "/#{self.filename}",
        :active => self.active
      )
      @menu_item.save
    end

    def create_starter_block
      Block.new(
        :show_title => true,
        :title => "#{self.meta_title} Page Content", 
        :body => "<h1> #{self.meta_title} </h1> <p>New content.</p>", 
        :classes => "twelve columns", 
        :where_to_show => 'content', 
        :show => "/#{self.filename}",
        :weight => 0
      ).save
    end

    #-- Map Creation --#
    def map
      map = GMap.new("map_div")
      map.control_init(:small => true, :large_map => true)
      map.center_zoom_init([42.722394, -87.88849],11)
      map.overlay_init(GMarker.new([42.721868, -87.887433],
        :title => "", 
        :info_window => "
          <h2>Dust CMS</h2>
          8338 Corporate Drive, Racine, WI 53406<br>
          <strong>Voice</strong> 262.898.2020 <strong>Fax</strong> 262.898.1010
        ")
      )
      map
    end

  end
end
