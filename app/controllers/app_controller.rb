class AppController < ApplicationController
    
  #POST /app/login with params: { nickname: , password: , push_token: }
  def login
    puts '로그인을 시작합니다.'
    nickname = params[:nickname]
    password = params[:password]
    push_token = params[:push_token]
    print "NICKNAME : #{nickname} || "
    print "PUSH_TOKEN : #{push_token} || "
    puts "PASSWORD : #{password} "
    
    # 유저 검색
    @user = User.find_by(nickname: nickname)
    
    # 닉네임이 존재 하는지?
    if @user
      puts "사용자가 존재합니다."
      
      if @user.authenticate(password)
        puts "비밀번호가 일치합니다"
        
        if @user.email_confirmed == false 
          puts "\e[#{31}m#{"  아직 아직 인증되지 않은 계정입니다.  "}\e[0m"
          @res = {"status" => "FAIL", "msg" => "아직 인증되지 않은 계정입니다."}          
        else
          puts "로그인 토큰 생성 및 푸쉬 토큰을 저장합니다."
          time = Time.now.to_s.split(' ')
          time.pop
          token = "#{nickname}|#{time.join(' ')}|LUNCHTING"
          @user.token = token
          @user.push_token = push_token
          
          if @user.save
            puts "TOKEN : #{token}"
            @res = {"status" => "OK","token" => "#{token}"}
            puts @res
            puts "\e[#{32}m#{"  로그인에 성공했습니다.  "}\e[0m"
          else
            puts "\e[#{31}m#{"  토큰 저장(갱신)에 실패했습니다.  "}\e[0m"
            @res = {"status" => "FAIL", "msg" => "토큰 저장(갱신)에 실패했습니다"}
          end          
          
        end
        

        
      else
        puts "비밀번호가 일치하지 않습니다"
        @res = {"status" => "FAIL", "msg" => "비밀번호가 일치하지 않습니다."}
        puts "\e[#{31}m#{"  로그인에 실패했습니다.  "}\e[0m"          
      end
        
    else
      puts "해당 사용자가 존재하지 않습니다."
      @res = {"status" => "FAIL", "msg" => "해당 사용자가 존재하지 않습니다."}
      puts "\e[#{31}m#{"  로그인에 실패했습니다.  "}\e[0m"        
    end

    render json: @res
  end



  #DELETE /users with params: { token: }
  def delete
    # 테스팅용 딜레이
    sleep 2
    puts "로그아웃을 시작합니다."

    token = params[:token]

    if token == nil
      puts "\e[#{31}m#{"  토큰이 없습니다.  "}\e[0m"
      @res = {"status" => "FAIL", "msg" => "No Token"}
      render json: @res
      # 토큰이 없으므로 delete 액션 종료
      return
    end

    @user = User.find_by(token: token)

    if @user
      @user.token = nil
      if @user.save
        puts "\e[#{32}m#{"  로그아웃에 성공했습니다.  "}\e[0m"
        @res = {"status" => "OK","msg" => "Logout Success"}
      else
        puts "\e[#{31}m#{" 로그아웃 실패 : 토큰 삭제에 실패했습니다.  "}\e[0m"
        @res = {"status" => "FAIL", "msg" => "Fail to Logout"}
      end
    else
      puts "\e[#{31}m#{"  해당 토큰을 가진 유저가 없습니다.  "}\e[0m"
      @res = {"status" => "FAIL", "msg" => "Inappropriate Token"}
    end

    render json: @res
  end
  
  def meetings
    puts params[:token]
    
    if params[:token].nil?
      puts '토큰이 없습니다. 허용되지 않은 경로입니다.'
      @res = {status: "ERROR", result: "토큰 없이 접근할 수 없습니다."}
      render json: @res
      return false
    end
    
    @user = User.where(token: params[:token])
    if !@user.empty?
      puts '토큰 확인'
      puts "유저 : #{@user}"
      
      # @user.first가 직접적인 유저 모델(배열에 한 개 담겨 있다.)
      puts "예정된 미팅 수 : #{@user.first.meetings.count}"
      puts @user.first.meetings.first.as_json.pretty_inspect
      @res = @user.first.meetings.order(:date).as_json
      # 성별을 추가해서 전달. 이후 이는 앱에서 제거되어 출력할 예정
      @res << { status: "ok", gender: @user.first.gender }
      
      render json: @res
    else
      puts '미인증 토큰'
      @res = {status: "fail", result: "인증이 만료되었습니다. 다시 로그인해주세요."}
      render json: @res
    end
  end
  
  def signup
    puts "데이터 수신 시작"
    
    puts "닉네임 : #{params[:nickname]}"
    puts "비밀번호 : #{params[:password]}"
    puts "성별 : #{params[:gender]}"
    puts "나이 : #{params[:age]}"
    puts "이미지 : #{params[:card].inspect}"
    
    @user = User.new
    @user.nickname = params[:nickname]
    @user.password = params[:password]
    if params[:gender] == "male"
      @user.gender = "m"
    else
      @user.gender = "f"
    end
    @user.card = params[:card]
    
    if @user.save
      puts "유저 저장 성공!!"
    else
      puts "유저 저장 실패!!"
    end
    
    
    
    @res = {status: "ok", msg: "hi there"}
    
    render json: @res
  end
  
  def checkuniq
    if User.where(nickname: params[:nickname]).count == 0
      @res = {status: "ok", msg: " 사용가능한 아이디입니다.", checkedNickname: params[:nickname]}
    else
      @res = {status: "fail", msg: " 사용중인 아이디입니다."}
    end
    
    render json: @res
  end
  
  def checkcompanion
    if User.where(nickname: params[:nickname]).count != 0
      @res = {status: "ok", msg: "인증되었습니다.", checkedNickname: params[:nickname]}
    else
      @res = {status: "fail", msg: "등록되지 않은 닉네임입니다."}
    end
    
    render json: @res
  end
  
end
