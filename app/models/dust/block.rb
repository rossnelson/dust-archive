module Dust
  class Block < ActiveRecord::Base
    attr_accessible :title, :body, :partial_name, :where_to_show, :show, :show_title, :classes, :weight, :column_span, :column_offset

    @regions = ['header_one', 'slider', 'content-default', 'footer']

    default_scope :order => 'weight ASC'

    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::SanitizeHelper

    validates_presence_of :title
    validates_uniqueness_of :title

    def self.regions
      pretty_regions = []
      @regions.each do |region|
        pretty_regions << [region.humanize.titleize, region]
      end
      Dust::Page.all.each do |page|
        pretty_regions.concat page.sections.map{ |s| ["#{page.nav_link} | #{s.title}", s.title.parameterize] } unless page.sections.blank?
      end
      pretty_regions
    end

    def self.grid
      grid = OpenStruct.new
      grid.columns = (1..12).map{ |i| [i.to_words.titleize, "#{i.to_words} columns"] }
      grid.offsets = (1..12).map{|i| ["Offset by #{i.to_words.titleize}", "offset-by-#{i.to_words}"]}
      grid
    end

    def self.page(search, page)
      search(search).paginate(:per_page => 12, :page => page)
    end

    def self.search(search)
      if search
        where("title LIKE ? OR body LIKE ?", "%#{search}%", "%#{search}%").where("show_title = ? OR 'show' != ?", false, '')
      else
        scoped
      end
    end

    def final_classes
      [column_span, column_offset, classes].join(" ")
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
      Dir.chdir("#{Rails.root}/app/views/widgets/")
      Dir["**/**"].select{|f|File.file? f}.each do |filename|
        if filename[0] != "." # if file is not hidden
          files.push filename.sub('_', '').gsub('.html.haml', '')
        end
      end
      files
    end
  end
end
