module Dust
  class Contact < ActiveRecord::Base
    attr_accessible :name, :email, :company_name, :phone, :address, :city, :state, :zip, :message, :hear
    
    validates_presence_of :name
    validates_presence_of :email
    validates_format_of :email, :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i, :message => "Should look like an email address."
    validates_presence_of :message

    def self.total_on(date)
      where("date(created_at) = ?", date)
    end
    
    def self.page(search, page, date)
      with_permissions_to(:manage).search(search, date).order("created_at DESC").paginate(:per_page => 12, :page => page)
    end

    def deliver_messages
      PostOffice.contact_confirmation(self).deliver
      PostOffice.contact_request(self).deliver
    end

    def self.search(search, date)
      if search
        where("name LIKE ? OR email LIKE ? OR message LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
      elsif date
        where("date(created_at) IS ?", (Time.at(date.to_i / 1000)).to_date)
      else
        scoped
      end
    end

  end
end
