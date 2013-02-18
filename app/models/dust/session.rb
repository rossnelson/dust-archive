module Dust
  class Session
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :username, :password, :user, :remember_me

    validates_presence_of :username, :password
    validate :found_user?

    def initialize(attributes=nil, user=nil)
      attributes ||= {}
      @user = user
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def found_user?
      errors[:base] << "User not found" unless @user
    end

    def persisted?
      false
    end
  end
end
