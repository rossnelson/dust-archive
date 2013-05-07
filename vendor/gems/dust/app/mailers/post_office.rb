class PostOffice < ActionMailer::Base

  default :from => "no-reply@dust.com"

  def contact_confirmation(contact)
    @contact = contact
    mail(:to => "#{contact.name} <#{contact.email}>", :subject => "Your contact request has been sent.")
  end

  def contact_request(contact)
    @contact = contact
    mail(:to => default_recipient, :subject => "New contact request has been received.")
  end

  def password_reset_instructions(user)
    @user = user
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Password Reset Instructions", :content_type => "text/html")
  end

  def activation_needed_email(user)
    @user = user
    mail(:to => default_recipient, :subject => "User #{@user.username} is awaiting approval.", :content_type => "text/html")
  end

  def activation_success_email(user)
    @user = user
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Your Landmark Title account has been approved.", :content_type => "text/html")
  end

  def default_recipient
    Dust.site_wides.contact_info.default_recipient || "no-reply@dust.com"
  end

end
