class PostOffice < ActionMailer::Base

  @app_config = Hashie::Mash.new(YAML.load(File.read("#{Rails.root}/config/app_config.yml")	))

  default :from => "no-reply@landmarktitleracine.com"
  default :to => @app_config.contact_forms.default_recipient

  def contact_confirmation(contact)
    @contact = contact
    mail(:to => "#{contact.name} <#{contact.email}>", :subject => "Your contact request at #{SITE_URL} has been received.")
  end

  def contact_request(contact)
    @contact = contact
    mail(:subject => "New contact request at #{SITE_URL} has been received.")
  end

  def password_reset_instructions(user)
    @user = user
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Password Reset Instructions", :content_type => "text/html")
  end
  
  def activation_needed_email(user)
    @user = user
    mail(:subject => "User #{@user.username} is awaiting approval.", :content_type => "text/html")
  end
  
  def activation_success_email(user)
    @user = user
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Your Landmark Title account has been approved.", :content_type => "text/html")
  end

end
