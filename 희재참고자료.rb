User 컨트롤러 >> 그대로 쓸 필요는 없고 대충 어떤 건지만 보면 됨

class LoginController < ApplicationController
  #POST /users with params: { nickname: , password: }
  # check user with id/pw
  def create
    # 테스팅용 딜레이
    sleep 2
    puts '로그인을 시작합니다.'
    nickname = params[:nickname]
    password = params[:password]
    print "NICKNAME : #{nickname} || "
    puts "PASSWORD : #{password}"

    @user = User.find_by(nickname: nickname)
    if @user
      puts "유저가 존재합니다."

      if @user.password == password
        puts "비밀번호가 일치합니다"

        puts "토큰을 생성합니다."

        # 토큰을 생성하는 방식은 JWT 방식을 차용할 예정
        token = "#TO-#{nickname}#{password}-KEN#"
        @user.token = token

        if @user.save
          puts "TOKEN : #{token}"
          @res = {"status" => "OK","token" => "#{token}"}
          puts @res
          puts "\e[#{32}m#{"  로그인에 성공했습니다.  "}\e[0m"
        else
          puts "\e[#{31}m#{"  토큰 저장(갱신)에 실패했습니다.  "}\e[0m"
          @res = {"status" => "FAIL", "msg" => "토큰 저장(갱신)에 실패했습니다"}
        end

      else
        puts "비밀번호가 일치하지 않습니다"
        @res = {"status" => "FAIL", "msg" => "비밀번호가 일치하지 않습니다."}
        puts "\e[#{31}m#{"  로그인에 실패했습니다.  "}\e[0m"
      end
    else
      puts "해당 유저가 존재하지 않습니다."
      @res = {"status" => "FAIL", "msg" => "해당 유저가 존재하지 않습니다."}
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
end


