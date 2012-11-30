class Newsletter < ActiveRecord::Base
  attr_accessible :title, :document, :summary

  def self.page(search, page)
    with_permissions_to(:manage).search(search).order("title").paginate(:per_page => 12, :page => page)
  end

  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%")
    else
      scoped
    end
  end
end
