module Dust
  class User < ActiveRecord::Base
    authenticates_with_sorcery!

    attr_accessible :username, :password, :password_confirmation, :email, :role_id, :role

    belongs_to :role
    has_many :assignments
    has_many :roles, :through => :assignments

    validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
    validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => Proc.new{ |u| !u.password.blank? }
    validates_confirmation_of :password, :message => "should match confirmation", :if => Proc.new{ |u| !u.password.blank? }

    def role_symbols
      [(role.name).to_sym]
    end

    def has_role?(role)
      role_symbols.include?(role)
    end

    def is?(role)
      role_symbols.include?(role)
    end

    def self.page(search, page)
      search(search).paginate(:per_page => 12, :page => page)
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

  end
end
