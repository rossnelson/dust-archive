module Dust
  class Post < ActiveRecord::Base
    include Dust::Menu::ItemDependency
    mount_uploader :file, ImageUploader

    attr_accessible :body, :file, :published, :published_date, :share, :share_type, :title

    validates_presence_of :title, :body, :published_date

    def share_types
      ['Facebook', 'Twitter']
    end

    def published_date
      self.published_at.strftime("%Y/%m/%d")
    end

    def published_date=(date_str)
      self.published_at = Time.parse date_str
    end

    def slug
      "#{published_date}/#{title.parameterize}"
    end

    def filename
      slug
    end

    def filename=(filename="")
      self.menu_item.url = "/post/#{slug}"
    end
  end
end
