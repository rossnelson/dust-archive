module Dust
  class Block < ActiveRecord::Base
    attr_accessible :title, :body, :partial_name, :where_to_show, :show, :show_title, :classes, :weight
    
    @regions = ['header_one', 'header_two', 'slider', 'callouts', 'content-one', 'content-two', 'content-three', 'footer_one', 'footer_two']
    
    default_scope :order => 'weight ASC'
    
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::SanitizeHelper
    
    def self.regions
      pretty_regions = []
      @regions.each do |region|
        pretty_regions << [region.humanize.titleize, region]
      end
      pretty_regions
    end

    def self.page(search, page)
      with_permissions_to(:manage).search(search).order("title").paginate(:per_page => 12, :page => page)
    end

    def self.search(search)
      if search
        where("title LIKE ? OR body LIKE ?", "%#{search}%", "%#{search}%").where("show_title = ? OR 'show' != ?", false, '')
      else
        scoped
      end
    end
    
    def url_list
      show.split("\r\n")
    end
    
    def show_me?(uri)
      (url_list.include?(uri) || url_list.blank?)
    end
    
    def self.find_active(uri)
      blocks = Block.all
      blocks.delete_if {|b| !b.show_me?(uri) }
      blocks
    end
    
    def front_end_content
      options = {
        :block => self
      }

      Handlebar.render(body, options)
    end
    
    def self.widget_list
      files = []
      Dir.entries("#{Rails.root}/app/views/dust/blocks/widgets").each do |filename|
        if filename[0] != "." # if file is not hidden
          files.push filename.sub('_', '').gsub('.html.haml', '')
        end
      end
      files
    end
  end
end
