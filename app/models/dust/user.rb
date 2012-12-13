module Dust
  class User < ActiveRecord::Base
    authenticates_with_sorcery!
    
    attr_accessible :username, :password, :password_confirmation, :email, :role_id, :role
    
    belongs_to :role
    has_many :assignments
    has_many :roles, :through => :assignments
    
    validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
    validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
    validates_confirmation_of :password, :message => "should match confirmation", :if => :password
    
    def role_symbols
      [(role.name).to_sym]
    end
    
    def has_role?(role)
      self.role_symbols.include?(role)
    end

    def self.page(search, page)
      with_permissions_to(:manage).search(search).paginate(:per_page => 12, :page => page)
    end

    def self.search(search)
      if search
        where("username LIKE ?", "%#{search}%")
      else
        scoped
      end
    end
    
    def login
      username
    end

    def deliver_password_reset_instructions!
      reset_perishable_token!
      PostOffice.password_reset_instructions(self).deliver
    end
    
    def avatar
      # Gravatar
      require 'digest/md5'
      if self.respond_to?(:email) && !self.email.blank?
        email = self.email
      elsif self.user && self.user.respond_to?(:email) && !self.user.email.blank?
        email = self.user.email
      else
        return ''
      end
      
      hash = Digest::MD5.hexdigest(email.downcase)
      ret = "<img src=\"http://www.gravatar.com/avatar/#{hash}.jpg\" />"
    end

    
  end
end
