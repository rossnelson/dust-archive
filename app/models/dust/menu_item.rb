class MenuItem < ActiveRecord::Base
  attr_accessible :title, :url, :active, :lft, :rgt, :parent_id

  acts_as_nested_set

  belongs_to :linkable, :polymorphic => true
  #validates_uniqueness_of :url

  scope :sitemap, :select => 'url, created_at, updated_at', :limit => 50000

  def self.page(search, page)
    with_permissions_to(:manage).search(search).order("title").paginate(:per_page => 12, :page => page)
  end

  def self.manage(search)
    with_permissions_to(:manage).roots.search(search).order("title")
  end

  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%")
    else
      scoped
    end
  end
  
  def self.menu
    list = self.roots
    list.where("active = ?", true)
  end
  
  def edit_linkable
    "/#{root.linkable_type.downcase.pluralize}/#{root.linkable_id}/edit"
  end
  
  def destroy_linkable
    "/#{root.linkable_type.downcase.pluralize}/#{root.linkable_id}"
  end
  
  def children_urls
    self.descendants.map{ |item| item.url }
  end

  REGEX = '^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$'

  def html_options?(uri)
    mash = Hashie::Mash.new 

    mash.class = "last" if self == self.self_and_siblings.all(:conditions => ['active = ?', true]).last
    mash.target = "_blank" if url.match(REGEX)
    mash.class = "active" if self.is_active? uri
    mash.class = "active last" if (self.is_active? uri) and self == self.self_and_siblings.last
    mash
  end
  
  def is_active?(uri)
    true if uri == url or children_urls.include?(uri) or (uri == "/" and self.url == "/welcome")
  end
  
end
