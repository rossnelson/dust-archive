class Post < ActiveRecord::Base
  attr_accessible :title, :content, :published, :published_at, :share, :image

  before_save :publish, :save_filename
  
  #has_attached_file :image, :styles => {:large => '800>', :medium => "300x300>", :thumb => "85x50#" }
  mount_uploader :image, PostImageUploader
  
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::TextHelper

  def publish
    if (published_changed? and published_at.blank?)
      self.published_at = Time.now
    end
  end

  def save_filename
    if published_changed? or title_changed? or slug.blank?
      date = self.published_at.strftime("%Y-%m-%d")
      filename = self.title.parameterize
      self.slug = "#{date}-#{filename}"
    end
  end

  def published_date
    "Published: #{published_at.strftime("%x")}"
  end
  
  def self.recent
    where('published = ?', true).order("published_at DESC").limit(3)
  end

  def self.feed
    where('published = ? AND share = ?', true, true).order("published_at DESC")
  end

  def self.archive(page)
    order("published_at DESC").offset(5).where('published = ?', true).paginate(:per_page => 12, :page => page)
  end

  def self.page(search, page)
    with_permissions_to(:manage).search(search).order("published_at DESC").paginate(:per_page => 12, :page => page)
  end

  def self.search(search)
    if search
      where("title LIKE ?", "%#{search}%").order("published_at DESC")
    else
      scoped
    end
  end
  
  def preview(count=120)
    truncated = truncate strip_tags(content), :length => count, :separator => ' '
  end
  
  def self.all_published
    where('published = ?', true).order("published_at DESC")
  end
end
