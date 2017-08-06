class UserMailer < ActionMailer::Base
    default :from => "whehdrms123@likelion.org"

 def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.nickname} <#{user.email}>", :subject => "Registration Confirmation")
 end
 def id_confirmation(user)
    @user = user
    mail(:to => "#{user.nickname} <#{user.email}>", :subject => "id Confirmation")
 end

 def password_confirmation(user)
    @user = user
    mail(:to => "#{user.nickname} <#{user.email}>", :subject => "password Confirmation")
 end
end