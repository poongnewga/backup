class ChatController < ApplicationController
  def index
    @room = params[:id]
    day_row = Meeting.find(params[:id]).day
    
    if day_row == "월"
      @day = "mon"
    elsif day_row == "화"
      @day = "tue"
    elsif day_row == "수"
      @day = "wed"
    elsif day_row == "목"
      @day = "thu"  
    elsif day_row == "금"
      @day = "fri"
    end
    
  end
end
