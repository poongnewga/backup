class UsersController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user, except: [:create, :new, :validate, :confirm_email]
  
  def index
    @meetings = current_user.meetings
    @groups = current_user.groups.where(matched: false)
    timesplit = Time.now.to_s.split("-")
    @time_now = (timesplit[0] + timesplit[1] + timesplit[2].split(" ")[0]).to_i
    timesplit2 = Time.now.at_beginning_of_week.to_s.split("-")
    @weekstart = (timesplit2[0] + timesplit2[1] + timesplit2[2].split(" ")[0]).to_i
    timesplit3 = (Time.now.at_beginning_of_week + 7.day).to_s.split("-")
    @nextweek = (timesplit3[0] + timesplit3[1] + timesplit3[2].split(" ")[0]).to_i
  end

  def new
  end
  
  def create
    if params[:gender] == "남"
      gen = "m"
    else 
      gen = "f"
    end


    @user = User.new(nickname: params[:nickname],
                  card: params[:card],
  	              password: params[:password],
  	              password_confirmation: params[:password_confirmation],
  	              age: params[:birthday],
  	              gender: gen,
  	              token: "#{params[:nickname]}|#{params[:gender]}|#{Time.now}|Lunchting",
  	              push_token: "#{params[:nickname]}-push_token")
    @user.save
    
    if @user.save
      redirect_to '/'
    else
      redirect_to :back
    end
	end


  def edit
    @user = User.find(params[:id])
  end

  def update
    # @user = User.find(params[:id])
    
    # if !(params[:current_password] == current_user.password)
    #   if !params[:password].nil?
    #     @user.update(age: params[:age])
    #   elsif (params[:password] != params[:password_confirmation])
    #   else (params[:password] == params[:password_confirmation])
    #     @user.update(age: params[:age], password: params[:password], password_confirmation: params[:password_confirmation])
    #   end
    # end
    
    redirect_to users_path
  end
  
  def confirm_email
    user = User.find_by(confirm_token: params[:id])
    if user
      user.email_activate
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  
  def authenticate_user
    if current_user.nil?
      redirect_to new_session_path
    end
  end
  
  def validate
    @user = User.where(nickname: params[:nickname])

    if (@user.empty?)
      puts '성공'
      @result = "pass"
    else
      puts '실패'
      @result = "fail"
    end
  end
  
  def editvalidate
    @user = User.find(params[:id])
    
      if @user.authenticate (params[:current_password])
        if params[:password] == ""
          @user.update(age: params[:age])
          @result = "updated"
        else
          if (params[:password] != params[:password_confirmation])
            @result = "pw_nomatch"
          else
            @user.update(age: params[:age], password: params[:password], password_confirmation: params[:password_confirmation])
            @result = "updated"
          end
        end
      else
        @result = "pw_nomatch"
      end
  end
end
