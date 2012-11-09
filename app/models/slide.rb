class Slide < ActiveRecord::Base
  include Nivo::ManageSlides

  scope :active_slides, where(:active => true)
  scope :inactive_slides, where(:active => false)
  
  attr_accessible :active, :url, :image, :caption

  mount_uploader :image, SlideImageUploader

  ##
  # Find for slideshow
  #
  def self.rotate
    where("active = ?", true).order("position")
  end

  ##
  # Find for admin index
  #
  def self.paginate_all(search)
      with_permissions_to(:manage).search(search).order("position")
  end

  ##
  # currently used in self.paginate_all
  #
  def self.search(search)
    if search
      where("caption LIKE ?", "%#{search}%")
    else
      scoped
    end
  end
end