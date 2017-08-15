class FindController < ApplicationController
  protect_from_forgery with: :exception
  def id_index
  end

  def password_index
  end

  def find_id
     user = User.find_by(email: params[:email])
     if user
        UserMailer.id_confirmation(user).deliver
     end
  end

  def find_password
     user = User.find_by(nickname: params[:nickname])
     if user
        UserMailer.password_confirmation(user).deliver
        user.password = '1234'
      end
  end
end
