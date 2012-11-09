class Photo < ActiveRecord::Base

  acts_as_nested_set

  belongs_to :album
  has_attached_file :file, :styles => {:large => '800>', :medium => "300x300>", :thumb => "100x100#" }
  validates_presence_of :album

  def self.page(search, page)
    with_permissions_to(:manage).search(search).order("title").paginate(:per_page => 20, :page => page)
  end

  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%")
    else
      scoped
    end
  end

  def self.album_page(page)
    roots.paginate(:per_page => 24, :page => page)
  end

end
