class UserMailer < ApplicationMailer
  default from: "russel.cse05@gmail.com"

  def welcome_mail(user)
    @user = user
    @url = "www.google.com"
    mail(to: @user.email,subject: 'Welcome to bSnap')
  end
end
