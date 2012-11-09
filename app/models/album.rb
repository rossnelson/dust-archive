class Album < ActiveRecord::Base

  acts_as_nested_set

  has_many :photos, :dependent => :destroy

  validates_presence_of :title
  validates_presence_of :filename
  validates_uniqueness_of :filename

  def self.page(search, page)
    with_permissions_to(:manage).search(search).order("title").paginate(:per_page => 10, :page => page)
  end

  def self.view(page)
    roots.paginate(:per_page => 10, :page => page)
  end

  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%")
    else
      scoped
    end
  end

  has_one :menu_item, :as => :linkable, :dependent => :destroy

  # after_create :create_menu_item
  # after_update :update_menu_item

  def update_menu_item
    @menu_item = self.menu_item
    if @menu_item == nil
      self.create_menu_item
    else
      @menu_item.update_attributes( 
                                   :title => self.title,
                                   :url => "/photos-for/#{self.filename}",
                                   :active => self.active
                                  )
    end
  end

  def create_menu_item
    @menu_item = self.build_menu_item(
      :title => self.title,
      :url => "/photos-for/#{self.filename}",
      :active => self.active
    )
    @menu_item.save
  end

end
