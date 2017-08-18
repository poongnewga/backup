class AdminController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user, :check_admin 
  def index
    @user = User.where(email_confirmed: false)
  end

  def mail_send
    @user = User.find(params[:id])
    @user.email = params[:email]
    @user.company = params[:company]
    @user.save
    UserMailer.registration_confirmation(@user).deliver
    flash[:alert] = "명함속 메일로 메일을 보냈습니다."
    redirect_to root_path
  end

  def matching
    timesplit2 = (Time.now.at_beginning_of_week + 7.day).to_s.split("-")
    @nextweekstart = (timesplit2[0] + timesplit2[1] + timesplit2[2].split(" ")[0]).to_i
    @groups = Group.where(week: @nextweekstart)
    @nogroups = @groups.where(matched: false)
    @fgroups = @nogroups.where(gender: "f")
    @daylist = ["mon", "tue", "wed", "thu", "fri"]
    @daylist_h = {"mon": 1, "tue": 2, "wed": 3, "thu": 4, "fri": 5}
    @daylist_hr = {"1": "월", "2": "화", "3": "수", "4": "목", "5": "금"}
    puts "f그룹"
    puts @fgroups
    @fgroups.order("id").each do |f|
      @candy = []
      @final_candy = []
      @can = {}
      @final_days = []
      @nogroups_pre = @groups.where(matched: false)
      @nogroups = @nogroups_pre.where.not(company: f.company)
      puts "노그룹"
      puts @nogroups
      @mgroups = @nogroups.where(gender: "m")
      puts "엠그룹"
      puts @mgroups
      @mgroups.where(people: f.people.to_i).each do |m|
        @timediffs  = {}
        puts "각엠"
        puts m
        puts m.id
        @days = []
        @daylist.each do |d|
          puts "먼저 각D"
          puts d
          if ("1" == JSON.parse(m.day)[d] && "1" == JSON.parse(f.day)[d])
            puts "속 각D"
            puts d
            @days << d
          end
        end
        puts "데이즈"
        puts @days
        if !@days.empty?
          puts Geocoder::Calculations.distance_between([JSON.parse(m.location)["latitude"].to_f,JSON.parse(m.location)["longitude"].to_f], [JSON.parse(f.location)["latitude"].to_f,JSON.parse(f.location)["longitude"].to_f])
          if 30 >= Geocoder::Calculations.distance_between([JSON.parse(m.location)["latitude"].to_f,JSON.parse(m.location)["longitude"].to_f], [JSON.parse(f.location)["latitude"].to_f,JSON.parse(f.location)["longitude"].to_f])
            puts "비교성공"
            larges = [(JSON.parse(m.lunchtime)["start"].split(/[\s: ]/)[0]+JSON.parse(m.lunchtime)["start"].split(/[\s: ]/)[1]).to_i, (JSON.parse(f.lunchtime)["start"].split(/[\s: ]/)[0] + JSON.parse(f.lunchtime)["start"].split(/[\s: ]/)[1]).to_i].max
            smallf = [(JSON.parse(m.lunchtime)["finish"].split(/[\s: ]/)[0]+JSON.parse(m.lunchtime)["finish"].split(/[\s: ]/)[1]).to_i, (JSON.parse(f.lunchtime)["finish"].split(/[\s: ]/)[0] + JSON.parse(f.lunchtime)["finish"].split(/[\s: ]/)[1]).to_i].min
            if larges < smallf
              timediff = Time.diff(Time.parse("#{larges.to_s.split("")[0]}+#{larges.to_s.split("")[1]}"+":"+"#{larges.to_s.split("")[3]}+#{larges.to_s.split("")[4]}"), Time.parse("#{smallf.to_s.split("")[0]}+#{smallf.to_s.split("")[1]}"+":"+"#{smallf.to_s.split("")[3]}+#{smallf.to_s.split("")[4]}"), '%h %m ')[:diff].split(" ")
              diff = (timediff[0].to_i*60) + (timediff[1].to_i)
              if diff.to_i >= 30
                @candy << m
                @can[m.id] = diff
              end
            end
          end
        end
      end
      #date 계산
      puts "캔과 캔디"
      puts @can
      puts @candy
      if !@can.first.nil? && !@candy.first.nil?
        can_id = @can.sort_by { |id, diff| diff }.last[0]
        puts "캔아이디"
        puts can_id
        @candy.each do |c|
          if c.id == can_id
            @final_candy << c
          end
        end
        final_m = @final_candy.first
        puts "최종 유저 모델 선정"
        puts final_m
        @daylist_h.each do |key, value|
            if ("1" == JSON.parse(final_m.day)[key.to_s] && "1" == JSON.parse(f.day)[key.to_s])
              @final_days << value
            end
        end
        puts "겹치는 요일들"
        puts @final_days
        @final_day = @final_days.sample
        puts "뽑힌 요일"
        puts @final_day
        @final_yoil = @daylist_hr[:"#{@final_day}"]
        puts @final_yoil
        timesplit10 = (Time.now.at_beginning_of_week + 6.day + @final_day.day).to_s.split("-")
        @meetingday = (timesplit10[0] + timesplit10[1] + timesplit10[2].split(" ")[0]).to_i

        #점심시간 계산
        larges = [(JSON.parse(final_m.lunchtime)["start"].split(/[\s: ]/)[0]+JSON.parse(final_m.lunchtime)["start"].split(/[\s: ]/)[1]).to_i, (JSON.parse(f.lunchtime)["start"].split(/[\s: ]/)[0] + JSON.parse(f.lunchtime)["start"].split(/[\s: ]/)[1]).to_i].max
        smallf = [(JSON.parse(final_m.lunchtime)["finish"].split(/[\s: ]/)[0]+JSON.parse(final_m.lunchtime)["finish"].split(/[\s: ]/)[1]).to_i, (JSON.parse(f.lunchtime)["finish"].split(/[\s: ]/)[0] + JSON.parse(f.lunchtime)["finish"].split(/[\s: ]/)[1]).to_i].min
        puts larges
        puts smallf
        finalstart = larges.to_s.split("")[0,2].join+":"+larges.to_s.split("")[2,2].join
        finalfinish = smallf.to_s.split("")[0,2].join+":"+smallf.to_s.split("")[2,2].join

        #중간지점 계산
        @pin_m = final_m.location
        @pin_f = f.location
        @p_count = (f.people)*2
        @company_m = final_m.company
        @company_f = f.company
        mid_location = Geocoder::Calculations.geographic_center([[JSON.parse(final_m.location)["latitude"], JSON.parse(final_m.location)["longitude"]], [JSON.parse(f.location)["latitude"], JSON.parse(f.location)["longitude"]]])

        @newmeeting = Meeting.create(date: @meetingday, day: @final_yoil, lunchtime: ({"start": finalstart, "finish": finalfinish}).to_json, center: ({"latitude": mid_location[0], "longitude": mid_location[1]}).to_json, pin_m: @pin_m, pin_f: @pin_f, p_count: @p_count, company: ({male: @company_m, female: @company_f}).to_json)
        final_m.meetings << @newmeeting
        f.meetings << @newmeeting
        f.matched = true
        final_m.matched = true
        f.save
        final_m.save
      end
    end

    redirect_to root_url
  end

  def authenticate_user
    if current_user.nil?
      redirect_to root_url
    end
  end

  def check_admin
    if !(current_user.admin == true)
      redirect_to root_url
    end
  end

end
