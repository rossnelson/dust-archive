module Dust
  class Page < ActiveRecord::Base
    attr_accessible :meta_title, :meta_description, :description, :classes
    has_many :sections

    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::SanitizeHelper
    include Dust::Menu::ItemDependency

    validates_presence_of :meta_title
    after_create :create_starter_block

    #-- ActiveRecord Queries --#
    def self.page(search, page)
      search(search).order("meta_title").paginate(:per_page => 12, :page => page)
    end

    def self.search(search)
      if search
        where("meta_title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%")
      else
        scoped
      end
    end

    def front_end_content
      options = { :page => self }
      Handlebar.render(content, options)
    end

    def create_description
      meta_description
    end

    def create_starter_block
      Block.new(
        :show_title => true,
        :title => "#{self.meta_title} Page Content", 
        :body => "<h1> #{self.meta_title} </h1> <p>New content.</p>", 
        :classes => "twelve columns", 
        :where_to_show => 'content-one', 
        :show => "/#{self.filename}",
        :weight => 0
      ).save
    end

  end
end
