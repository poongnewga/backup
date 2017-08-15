class AppController < ApplicationController
  # POST /app/login with params: { nickname: , password: , push_token: }
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
      # puts @user.first.meetings.first.as_json.pretty_inspect
      @meets = @user.first.meetings.order(:date)

      @m = []
      @n = []

      @meets.each do |meet|
        if meet.date >= Time.now.to_s.slice(0,10).split("-").join().to_i
          @m << meet
        else
          @n << meet
        end
      end
      puts '예정'
      puts @m.inspect
      puts '과거'
      puts @n.inspect

      @res = @m.as_json
      # puts @res
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
    @user.age = params[:age]
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
  
  def search
    puts params[:query]
    
    @res = {status: "ok", data: "data"}
    
    render json: @res
  end
  
  def refresh_posts
    if @user = User.find_by(token: params[:token])
      puts '유저 존재'
      @posts = []
      
      Post.order(created_at: :desc).limit(4).each do |post|
        i = post.id
        t = post.created_at.to_s
        n = post.user.nickname
        g =  post.user.gender
        l =  post.likes.count
        c = post.comments.count
        post = post.as_json
        post.delete("content")
        post.delete("updated_at")
        # puts t.class
        post[:created_at] = "#{t.slice(0,4)}년 #{t.slice(5,2)}월 #{t.slice(8,2)}일"  
        # puts post[:created_at]
        post[:from] = n
        post[:gender] = g
        post[:likeCount] = l
        
        like = Like.find_by(user_id: @user.id,
                            post_id: i)
    
        if like.nil?
          post[:liked] = false
        else
          post[:liked] = true
        end         
        
        post[:commentCount] = c

        @posts << post
      end
      
      @res = {status: "ok", data: @posts}
    else
      @res = {status: "fail", msg: "토큰만료"}
    end
    
    
    render json: @res
    
  end
  
  def get_page
    if @user = User.find_by(token: params[:token])
      puts '유저 존재'
      @posts = []
      
      if (Post.order(created_at: :desc).limit(4).offset((params[:page].to_i-1)*4).empty?)
        @res = {status: "fail", msg: "데이터가 없습니다."}
        render json: @res
        return false
      end
      
      Post.order(created_at: :desc).limit(4).offset((params[:page].to_i-1)*4).each do |post|
        i = post.id
        t = post.created_at.to_s
        n = post.user.nickname
        g =  post.user.gender
        l =  post.likes.count
        c = post.comments.count
        post = post.as_json
        post.delete("content")
        post.delete("updated_at")
        # puts t.class
        post[:created_at] = "#{t.slice(0,4)}년 #{t.slice(5,2)}월 #{t.slice(8,2)}일"  
        # puts post[:created_at]
        post[:from] = n
        post[:gender] = g
        post[:likeCount] = l
        
        like = Like.find_by(user_id: @user.id,
                            post_id: i)
    
        if like.nil?
          puts "좋아하지 않음"
          post[:liked] = false
        else
          puts "좋아함"
          post[:liked] = true
        end         
        
        post[:commentCount] = c

        @posts << post
      end
      
      @res = {status: "ok", data: @posts}
    else
      @res = {status: "fail", msg: "토큰만료"}
    end
    render json: @res
  end
  
  def get_search_page
    if @user = User.find_by(token: params[:token])
      puts '유저 존재'
      @posts = []
      
      if (Post.where("title LIKE ?", "%#{params[:query].strip}%").order(created_at: :desc).limit(4).offset((params[:page].to_i-1)*4).empty?)
        @res = {status: "fail", msg: "데이터가 없습니다."}
        render json: @res
        return false
      end
      
      Post.where("title LIKE ?", "%#{params[:query].strip}%").order(created_at: :desc).limit(4).offset((params[:page].to_i-1)*4).each do |post|
        i = post.id
        t = post.created_at.to_s
        n = post.user.nickname
        g =  post.user.gender
        l =  post.likes.count
        c = post.comments.count
        post = post.as_json
        post.delete("content")
        post.delete("updated_at")
        # puts t.class
        post[:created_at] = "#{t.slice(0,4)}년 #{t.slice(5,2)}월 #{t.slice(8,2)}일"  
        # puts post[:created_at]
        post[:from] = n
        post[:gender] = g
        post[:likeCount] = l
        
        like = Like.find_by(user_id: @user.id,
                            post_id: i)
    
        if like.nil?
          post[:liked] = false
        else
          post[:liked] = true
        end         
        
        post[:commentCount] = c

        @posts << post
      end
      
      @res = {status: "ok", data: @posts}
    else
      @res = {status: "fail", msg: "토큰만료"}
    end
    render json: @res
  end
  
  def refresh_search_posts
    if @user = User.find_by(token: params[:token])
      puts '유저 존재'
      @posts = []
      
      Post.where("title LIKE ?", "%#{params[:query].strip}%").order(created_at: :desc).limit(4).each do |post|
        i = post.id
        t = post.created_at.to_s
        n = post.user.nickname
        g =  post.user.gender
        l =  post.likes.count
        c = post.comments.count
        post = post.as_json
        post.delete("content")
        post.delete("updated_at")
        # puts t.class
        post[:created_at] = "#{t.slice(0,4)}년 #{t.slice(5,2)}월 #{t.slice(8,2)}일"  
        # puts post[:created_at]
        post[:from] = n
        post[:gender] = g
        post[:likeCount] = l
        
        like = Like.find_by(user_id: @user.id,
                            post_id: i)
    
        if like.nil?
          post[:liked] = false
        else
          post[:liked] = true
        end          
        
        post[:commentCount] = c

        @posts << post
      end
      
      @res = {status: "ok", data: @posts}
    else
      @res = {status: "fail", msg: "토큰만료"}
    end
    
    
    render json: @res
    
  end  
  
  def get_post
    if @user = User.find_by(token: params[:token])
      puts '유저 존재'
      
      @post = Post.find_by(id: params[:id])
      
      @comments = []
      
      @post.comments.each do |comment|
        ct = comment.created_at.to_s
        @comment = {}
        @comment[:id] = comment.id
        @comment[:nickname] = comment.user.nickname
        @comment[:gender] = comment.user.gender
        @comment[:content] = comment.content
        @comment[:created_at] = "#{ct.slice(2,2)}.#{ct.slice(5,2)}.#{ct.slice(8,2)} #{ct.slice(11,2)}:#{ct.slice(14,2)}" 
        @comments << @comment
      end
      
      
      @post.hits += 1
      @post.save
      
      t = @post.created_at.to_s
      n = @post.user.nickname
      g = @post.user.gender
      l = @post.likes.count
      c = @post.comments.count
      
      post = @post.as_json
      post.delete("updated_at")
      post[:created_at] = "#{t.slice(0,4)}년 #{t.slice(5,2)}월 #{t.slice(8,2)}일 #{t.slice(11,2)}:#{t.slice(14,2)}"  
      post[:from] = n
      post[:gender] = g
      post[:likeCount] = l
      post[:commentCount] = c
      post[:nickname] = n
      
      like = Like.find_by(user_id: @user.id,
                          post_id: params[:id])
  
      if like.nil?
        post[:liked] = false
      else
        post[:liked] = true
      end         
      
      post[:comments] = @comments.as_json
      
      
      
      
      
      @res = {status: "ok", data: post}
    else
      @res = {status: "fail", msg: "토큰만료"}
    end
    
    
    render json: @res
    
  end  
  
  def write_comment
    if @user = User.find_by(token: params[:token])
      puts '유저 존재'
      
      @post = Post.find_by(id: params[:id])
      
      new_comment = @post.comments.build
      new_comment.user_id = @user.id
      new_comment.content = params[:content]
      new_comment.save
      
      @comments = []
      
      @post.comments.each do |comment|
        ct = comment.created_at.to_s
        @comment = {}
        @comment[:id] = comment.id
        @comment[:nickname] = comment.user.nickname
        @comment[:gender] = comment.user.gender
        @comment[:content] = comment.content
        @comment[:created_at] = "#{ct.slice(2,2)}.#{ct.slice(5,2)}.#{ct.slice(8,2)} #{ct.slice(11,2)}:#{ct.slice(14,2)}" 
        @comments << @comment
      end
      
      
      @post.hits += 1
      @post.save
      
      t = @post.created_at.to_s
      n = @post.user.nickname
      g = @post.user.gender
      l = @post.likes.count
      c = @post.comments.count
      
      post = @post.as_json
      post.delete("updated_at")
      post[:created_at] = "#{t.slice(0,4)}년 #{t.slice(5,2)}월 #{t.slice(8,2)}일 #{t.slice(11,2)}:#{t.slice(14,2)}"  
      post[:from] = n
      post[:gender] = g
      post[:likeCount] = l
      post[:commentCount] = c
      post[:nickname] = n
      
      like = Like.find_by(user_id: @user.id,
                          post_id: params[:id])
  
      if like.nil?
        post[:liked] = false
      else
        post[:liked] = true
      end         
      
      post[:comments] = @comments.as_json
      
      
      
      
      
      @res = {status: "ok", data: post}
    else
      @res = {status: "fail", msg: "토큰만료"}
    end
    
    
    render json: @res
    
  end
  
  def delete_comment
    if @user = User.find_by(token: params[:token])
      puts '유저 존재'
      
      @post = Post.find_by(id: params[:id])
      
      Comment.find_by(id: params[:comment_id]).destroy
      
      @comments = []
      
      @post.comments.each do |comment|
        ct = comment.created_at.to_s
        @comment = {}
        @comment[:id] = comment.id
        @comment[:nickname] = comment.user.nickname
        @comment[:gender] = comment.user.gender
        @comment[:content] = comment.content
        @comment[:created_at] = "#{ct.slice(2,2)}.#{ct.slice(5,2)}.#{ct.slice(8,2)} #{ct.slice(11,2)}:#{ct.slice(14,2)}" 
        @comments << @comment
      end
      
      
      @post.hits += 1
      @post.save
      
      t = @post.created_at.to_s
      n = @post.user.nickname
      g = @post.user.gender
      l = @post.likes.count
      c = @post.comments.count
      
      post = @post.as_json
      post.delete("updated_at")
      post[:created_at] = "#{t.slice(0,4)}년 #{t.slice(5,2)}월 #{t.slice(8,2)}일 #{t.slice(11,2)}:#{t.slice(14,2)}"  
      post[:from] = n
      post[:gender] = g
      post[:likeCount] = l
      post[:commentCount] = c
      post[:nickname] = n
      
      like = Like.find_by(user_id: @user.id,
                          post_id: params[:id])
  
      if like.nil?
        post[:liked] = false
      else
        post[:liked] = true
      end   
      
      post[:comments] = @comments.as_json
      
      
      
      
      
      @res = {status: "ok", data: post}
    else
      @res = {status: "fail", msg: "토큰만료"}
    end
    
    
    render json: @res
    
  end 
  
  def delete_post
    if @user = User.find_by(token: params[:token])
      puts '유저 존재'
      
      @post = Post.find_by(id: params[:id])
      
      @post.destroy

      @res = {status: "ok", msg: "포스트 삭제 성공"}
    else
      @res = {status: "fail", msg: "토큰만료"}
    end
    
    
    render json: @res
    
  end
  
  
  def like_toggle
    if @user = User.find_by(token: params[:token])
      puts '유저 존재'
      @post = Post.find_by(id: params[:id])
      
      like = Like.find_by(user_id: @user.id,
                          post_id: params[:id])
  
      if like.nil?
        Like.create(user_id: @user.id,
                    post_id: params[:id])
      else
        like.destroy
      end      
      
      
      
      @comments = []
      
      @post.comments.each do |comment|
        ct = comment.created_at.to_s
        @comment = {}
        @comment[:id] = comment.id
        @comment[:nickname] = comment.user.nickname
        @comment[:gender] = comment.user.gender
        @comment[:content] = comment.content
        @comment[:created_at] = "#{ct.slice(2,2)}.#{ct.slice(5,2)}.#{ct.slice(8,2)} #{ct.slice(11,2)}:#{ct.slice(14,2)}" 
        @comments << @comment
      end
      
      t = @post.created_at.to_s
      n = @post.user.nickname
      g = @post.user.gender
      l = @post.likes.count
      c = @post.comments.count
      
      post = @post.as_json
      post.delete("updated_at")
      post[:created_at] = "#{t.slice(0,4)}년 #{t.slice(5,2)}월 #{t.slice(8,2)}일 #{t.slice(11,2)}:#{t.slice(14,2)}"  
      post[:from] = n
      post[:gender] = g
      post[:likeCount] = l
      post[:commentCount] = c
      post[:nickname] = n
      
      like = Like.find_by(user_id: @user.id,
                          post_id: params[:id])
  
      if like.nil?
        post[:liked] = false
      else
        post[:liked] = true
      end    
      
      post[:comments] = @comments.as_json
      
      
   
      
      
      
      
      
      @res = {status: "ok", data: post}
    else
      @res = {status: "fail", msg: "토큰만료"}
    end
    
    
    render json: @res
    
  end  
 
  def write_new_post
    
    if @user = User.find_by(token: params[:token])
      puts '유저 존재'
      
      @post = Post.new
      @post.user_id = @user.id
      @post.title = params[:title]
      @post.content = params[:content]
      
      if @post.save
        @res = {status: "ok", msg: '글쓰기 성공'}
      else
        @res = {status: 'fail', msg: '글쓰기 실패'}
      end

    else
      @res = {status: "fail", msg: "토큰만료"}
    end
    
    
    render json: @res    
    
  end
  
  def enroll_group
    if @user = User.find_by(token: params[:token])
      puts '유저 존재'
      
      @day = JSON.parse(params[:day])
      @day.each do |k,v|
        if @day[k] == true
          @day[k] = "1"
        else
          @day[k] = "0"
        end
      end
      @day = @day.to_json      
      
      @group = Group.create(gender: @user.gender,
          people: params[:peopleCount],
          day: @day,
          week: params[:week],
          company: @user.company,
          matched: false,
          lunchtime: params[:lunchtime],
          location: params[:location]
        )
      @user.groups << @group
      
      @people = JSON.parse(params[:enrolledPeople])
      
      @people.each do |people|
        if people != nil
          User.find_by(nickname: people).groups << @group
          puts people          
        elsif people == nil
          puts '없습니다.'
        end
      end
      
      if params[:timeSaved] == "true"
        @user.location = params[:location]
      end
      
      if params[:locationSaved] == "true"
        @user.lunchtime = params[:lunchtime]
      end
      
      @user.save
      
      @res = {status: "ok", msg: "등록 성공"}

    else
      @res = {status: "fail", msg: "토큰만료"}
    end
    
    
    render json: @res      
  end
  
  def mypage
    if @user = User.find_by(token: params[:token])
      puts '유저 존재'
      
      @meets = @user.meetings.order(:date)

      @oldmeets = []
      @waits = []
      @res = {}

      @meets.each do |meet|
        if meet.date < Time.now.to_s.slice(0,10).split("-").join().to_i
          @oldmeets << meet
        end
      end
      
      @user.groups.each do |group|
        if group.matched == false
          @waits << group
        end
      end
      
      @res[:oldmeets] = @oldmeets.as_json
      @res[:waits] = @waits.as_json
      @res[:status] = "ok"

    else
      @res = {status: "fail", msg: "토큰만료"}
    end
    
    
    render json: @res      
  end
end

