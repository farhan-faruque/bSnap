ActionMailer::Base.register_interceptor(SendGrid::MailInterceptor)

ActionMailer::Base.smtp_settings = {
    :address => 'smtp.sendgrid.net',
    :port => '25',
    :domain => 'localhost:3000',
    :authentication => :plain,
    :user_name => Rails.application.secrets.SENDGRID_USERNAME,
    :password => Rails.application.secrets.SENDGRID_PASSWORD
}
