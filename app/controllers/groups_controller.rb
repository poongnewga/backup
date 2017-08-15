class GroupsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user
  
  def new
     days = [7, 8, 9, 10, 11]
    @dayshash = {}
    days.each do |x|
      timesplit = (Time.now.at_beginning_of_week + x.day).to_s.split("-")
      timesplit_x = timesplit[1] + "." + timesplit[2].split(" ")[0]
      @dayshash[x] = timesplit_x
    end
    
    timesplit2 = Time.now.at_beginning_of_week.to_s.split("-")
    timesplit29 = (Time.now.at_beginning_of_week + 7.day).to_s.split("-")
    @weekstart = (timesplit2[0] + timesplit2[1] + timesplit2[2].split(" ")[0]).to_i
    @nextweekstart = (timesplit29[0] + timesplit29[1] + timesplit29[2].split(" ")[0]).to_i
    
    if current_user.nil?
      flash[:alert] = "로그인 후 이용해주세요."
      redirect_to root_path
    else
      if @user_location = !current_user.location.nil? 
        @latitude = JSON.parse(current_user.location)["latitude"].to_f
        @longitude = JSON.parse(current_user.location)["longitude"].to_f
      else
        @latitude = 37.497942
        @longitude = 127.027621
      end
      
  
      if @user_lunchtime = !current_user.lunchtime.nil?
        @start = JSON.parse(current_user.lunchtime)["start"]
        @finish = JSON.parse(current_user.lunchtime)["finish"]
      end
    end

  end

  def create
    puts params[:lunchtime_save]

    @group = Group.create(gender: params[:gender],
                          people: params[:people],
                          day: {mon: params[:mon], tue: params[:tue], wed: params[:wed], thu: params[:thu], fri: params[:fri]}.to_json,
                          week: params[:week],
                          company: current_user.company,
                          matched: false,
                          lunchtime: {"start": params[:lunchtime_beg], "finish": params[:lunchtime_end]}.to_json,
                          location: {latitude: params[:location_lat], longitude: params[:location_lng]}.to_json
                          )
                       
    if params[:people] == "1"                      
      current_user.groups << @group
    elsif params[:people] == "2"
      current_user.groups << @group
      User.find_by(nickname: params[:add_nick1]).groups << @group
    elsif params[:people] == "3"
      current_user.groups << @group
      User.find_by(nickname: params[:add_nick1]).groups << @group
      User.find_by(nickname: params[:add_nick2]).groups << @group
     elsif params[:people] == "4"
      current_user.groups << @group
      User.find_by(nickname: params[:add_nick1]).groups << @group
      User.find_by(nickname: params[:add_nick2]).groups << @group
      User.find_by(nickname: params[:add_nick3]).groups << @group
    end
    

    if params[:location_save] == "1"
      @location = {
        latitude: params[:location_lat],
        longitude: params[:location_lng]
      }
      
      current_user.location = @location.to_json
      current_user.save
    end

    if params[:lunchtime_save] == "1"
	    @lunchtime = {
	      start: params[:lunchtime_beg],
	      finish: params[:lunchtime_end]
      }

      current_user.lunchtime = @lunchtime.to_json
	    current_user.save
    end

    redirect_to '/users'
  end
  
  def show
    @show_group = Group.find(params[:id])
  end
  
  def destroy
    @group = Group.find_by(id: params[:id])
    @group.destroy
    redirect_to :back
  end
  
  def validate
    @user = User.where(nickname: params[:user]) 

    
    if (@user.empty?)
      @result = "해당 닉네임을 가진 유저가 없습니다."
    elsif (params[:user] == current_user.nickname)
      puts '실패'
      @result = "본인 외의 유저를 선택해주세요."
    elsif (User.find_by(nickname: params[:user]).gender != current_user.gender)
      @result = "같은 성별의 유저를 선택해주세요."
    else
      puts '성공'
      @result = "인증되었습니다."
    end
    
  end
  
    def validate_edit
    @user = User.where(nickname: params[:user]) 

    
    if (@user.empty?)
      @result = "해당 닉네임을 가진 유저가 없습니다."
    elsif (params[:user] == current_user.nickname)
      puts '실패'
      @result = "본인 외의 유저를 선택해주세요."
    elsif (User.find_by(nickname: params[:user]).gender != current_user.gender)
      @result = "같은 성별의 유저를 선택해주세요."
    else
      puts '성공'
      @result = "인증되었습니다."
    end
    
  end
  
  def authenticate_user
    if current_user.nil?
      redirect_to new_session_path
    end
  end
  
  def edit
    @group = Group.find(params[:id])
      
  if (JSON.parse(@group.day)["mon"] == "1")
    @mon = true
  else
    @mon = false
  end
  
    if (JSON.parse(@group.day)["tue"] == "1")
    @tue = true
  else
    @tue = false
  end
  
    if (JSON.parse(@group.day)["wed"] == "1")
    @wed = true
  else
    @wed = false
  end
  
    if (JSON.parse(@group.day)["thu"] == "1")
    @thu = true
  else
    @thu = false
  end
  
    if (JSON.parse(@group.day)["fri"] == "1")
    @fri = true
  else
    @fri = false
  end
    
    if @group.people == 1
      @secondmember = ''
      @thirdmember = ''
      @fourthmember = ''
    elsif  @group.people == 2
      @secondmember = @group.users[1].nickname
      @thirdmember = ''
      @fourthmember = ''
    elsif @group.people == 3
      @secondmember = @group.users[1].nickname
      @thirdmember = @group.users[2].nickname
      @fourthmember = ''
    elsif @group.people == 4
      @secondmember = @group.users[1].nickname
      @thirdmember = @group.users[2].nickname
      @fourthmember = @group.users[3].nickname
    end
    
     days = [7, 8, 9, 10, 11]
    @dayshash = {}
    days.each do |x|
      timesplit = (Time.now.at_beginning_of_week + x.day).to_s.split("-")
      timesplit_x = timesplit[1] + "." + timesplit[2].split(" ")[0]
      @dayshash[x] = timesplit_x
    end
    
    timesplit2 = Time.now.at_beginning_of_week.to_s.split("-")
    timesplit29 = (Time.now.at_beginning_of_week + 7.day).to_s.split("-")
    @weekstart = (timesplit2[0] + timesplit2[1] + timesplit2[2].split(" ")[0]).to_i
    @nextweekstart = (timesplit29[0] + timesplit29[1] + timesplit29[2].split(" ")[0]).to_i
    
    @latitude = JSON.parse(@group.location)["latitude"].to_f
    @longitude = JSON.parse(@group.location)["longitude"].to_f

    @start = JSON.parse(@group.lunchtime)["start"]
    @finish = JSON.parse(@group.lunchtime)["finish"]
  end

  
  def update
    puts params[:lunchtime_save]

     @groupd = Group.find(params[:id])
     @groupd.destroy
     
    @group = Group.create(gender: params[:gender],
                          people: params[:people],
                          day: {mon: params[:mon], tue: params[:tue], wed: params[:wed], thu: params[:thu], fri: params[:fri]}.to_json,
                          week: params[:week],
                          company: current_user.company,
                          matched: false,
                          lunchtime: {"start": params[:lunchtime_beg], "finish": params[:lunchtime_end]}.to_json,
                          location: {latitude: params[:location_lat], longitude: params[:location_lng]}.to_json
                          )
                       
    if params[:people] == "1"                      
      current_user.groups << @group
    elsif params[:people] == "2"
      current_user.groups << @group
      User.find_by(nickname: params[:add_nick1]).groups << @group
    elsif params[:people] == "3"
      current_user.groups << @group
      User.find_by(nickname: params[:add_nick1]).groups << @group
      User.find_by(nickname: params[:add_nick2]).groups << @group
     elsif params[:people] == "4"
      current_user.groups << @group
      User.find_by(nickname: params[:add_nick1]).groups << @group
      User.find_by(nickname: params[:add_nick2]).groups << @group
      User.find_by(nickname: params[:add_nick3]).groups << @group
    end
    

    if params[:location_save] == "1"
      @location = {
        latitude: params[:location_lat],
        longitude: params[:location_lng]
      }
      
      current_user.location = @location.to_json
      current_user.save
    end

    if params[:lunchtime_save] == "1"
	    @lunchtime = {
	      start: params[:lunchtime_beg],
	      finish: params[:lunchtime_end]
      }

      current_user.lunchtime = @lunchtime.to_json
	    current_user.save
    end

    redirect_to '/users'
  end
end
