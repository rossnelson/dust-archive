class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  attr_accessible :username, :password, :password_confirmation, :email, :role
  
  belongs_to :role
	
	#validates_format_of :username, :format => { :with => /\A[a-zA-Z]+\z/, :message => "must be letters only." }
	validates_format_of :email, :with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i
	
	#after_create :send_approval_request, :if => Proc.new { |user| user.approved == false }
	#after_save :notify_of_approval, :if => Proc.new { |user| user.approved_changed? && user.approved == true }
	
	def send_approval_request
	  PostOffice.approval_request(self).deliver
  end
  
  def notify_of_approval
	  PostOffice.approval_notification(self).deliver
  end
	
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
