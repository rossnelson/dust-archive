class Testimonial < ActiveRecord::Base
  attr_accessible :quote, :attribution, :approved
  
  validates_presence_of :quote, :attribution

  def self.page(search, page)
    with_permissions_to(:manage).search(search).order("quote").paginate(:per_page => 12, :page => page)
  end

  def self.search(search)
    if search
      where("quote LIKE ?", "%#{search}%")
    else
      scoped
    end
  end
  
  def self.approved
    where :approved => true
  end
  
  def self.sorted_for_presentation
    n = rough_equivalent_of_the_space_a_newline_takes_up = "fdsfdsa" * 3
    approved.sort { |x,y| x.quote.gsub("\n", n).length <=> y.quote.gsub("\n", n).length }
  end
end