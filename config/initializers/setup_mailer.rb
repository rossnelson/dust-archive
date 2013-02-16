ActionMailer::Base.smtp_settings = {
  :address              => "mail.imagemanagement.com",
  :domain               => "naalloy.com",
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
