class CmsMenuItem < ActiveRecord::Base
  attr_accessible :title, :url, :controller_name, :lft, :rgt, :parent_id
  
  acts_as_nested_set

  validates_presence_of :title
  validates_presence_of :url
  
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
