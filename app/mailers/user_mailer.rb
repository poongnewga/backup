class UserMailer < ActionMailer::Base
    default :from => "whehdrms123@likelion.org"

 def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.nickname} <#{user.email}>", :subject => "[런치팅] 가입을 진심으로 환영합니다!")
 end
 def id_confirmation(user)
    @user = user
    mail(:to => "#{user.nickname} <#{user.email}>", :subject => "[런치팅] 아이디 찾기")
 end

 def password_confirmation(user)
    @user = user
    mail(:to => "#{user.nickname} <#{user.email}>", :subject => "[런치팅] 비밀번호 찾기")
 end
end