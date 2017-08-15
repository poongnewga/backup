class SessionsController < ApplicationController
  protect_from_forgery with: :exception
  def new
  end

  def create
    respond_to do |format|
      puts '로그인을 시작합니다.'
      nickname = params[:nickname]
      password = params[:password]
      print "NICKNAME : #{nickname} || "
      puts "PASSWORD : #{password}"

      @user = User.find_by(nickname: nickname)
      
      if @user
        puts "유저가 존재합니다."

        if @user.authenticate ("#{password}")
          puts "비밀번호가 일치합니다"
          
          if @user.email_confirmed == true
            format.html { 
              log_in(@user)
              redirect_to root_path
            }        
            format.json {
              puts "토큰을 생성합니다."
              token = "#TO-#{nickname}#{password}-KEN#"
              @user.token = token
            }
              if @user.save
                format.html {
                  puts "html유저의 접근"
                  log_in(@user)
                }
                format.json {
                  puts "TOKEN : #{token}"
                  @res = {"status" => "OK","token" => "#{token}"}
                  puts @res
                  puts "\e[#{32}m#{"  로그인에 성공했습니다.  "}\e[0m"
                }
            
              else
                format.json {
                  puts "\e[#{31}m#{"  토큰 저장(갱신)에 실패했습니다.  "}\e[0m"
                  @res = {"status" => "FAIL", "msg" => "토큰 저장(갱신)에 실패했습니다"}
                }
              end
          
          else
            flash[:error] = "이메일이 아직 확인되지 않았습니다."
            puts "이메일이 아직 확인되지 않았습니다."
            redirect_to new_session_path
          end
        
        else
          format.html {
            flash[:error] = "비밀번호가 일치하지 않습니다."
            puts "비밀번호가 일치하지 않습니다."
            redirect_to new_session_path    
        
          }
          format.json {
            puts "비밀번호가 일치하지 않습니다"
            @res = {"status" => "FAIL", "msg" => "비밀번호가 일치하지 않습니다."}
            puts "\e[#{31}m#{"  로그인에 실패했습니다.  "}\e[0m"
          }
        end
      
      else
        format.html {
          flash[:error] = "해당 유저가 존재하지 않습니다."
          puts "해당 유저가 존재하지 않습니다."
          redirect_to new_session_path
        }
        format.json { 
          puts "해당 유저가 존재하지 않습니다."
          @res = {"status" => "FAIL", "msg" => "해당 유저가 존재하지 않습니다."}
          puts "\e[#{31}m#{"  로그인에 실패했습니다.  "}\e[0m"
        }
      end
      format.html { }
      format.json { render json: @res }
    end
  end


  def destroy
  
	   puts "로그아웃을 시작합니다."
	   #session log-out
	   #token = current_user.token

	   #if token == nil
	   #  puts "\e[#{31}m#{"  토큰이 없습니다.  "}\e[0m"
	   #  @res = {"status" => "FAIL", "msg" => "No Token"}
	   #  render json: @res
	   #   # 토큰이 없으므로 delete 액션 종료
	   #  return
	   #end

	   #@user = User.find_by(token: token)

	   #if @user
	     #@user.token = nil
	     #if @user.save
	       #puts "\e[#{32}m#{"  로그아웃에 성공했습니다.  "}\e[0m"
	       #@res = {"status" => "OK","msg" => "Logout Success"}
	   log_out
	   redirect_to '/'
	     #else
	       #puts "\e[#{31}m#{" 로그아웃 실패 : 토큰 삭제에 실패했습니다.  "}\e[0m"
	       #@res = {"status" => "FAIL", "msg" => "Fail to Logout"}
	     #end
	 #  else
	 #    puts "\e[#{31}m#{"  해당 토큰을 가진 유저가 없습니다.  "}\e[0m"
	 #    @res = {"status" => "FAIL", "msg" => "Inappropriate Token"}
	 #  end
	 end
end