module Dust
  class Post < ActiveRecord::Base
    include Dust::Menu::ItemDependency

    attr_accessible :body, :file, :published, :published_at, :share, :share_type, :title

    validates_presence_of :title, :body
  end
end
