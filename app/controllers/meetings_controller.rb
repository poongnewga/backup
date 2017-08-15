class MeetingsController < ApplicationController
  protect_from_forgery with: :exception
  def new

  end
  def create
    @meeting = Meeting.create(date: params[:date])
    Group.find(params[:id1]).meetings << @meeting
    Group.find(params[:id2]).meetings << @meeting
    redirect_to :root
  end
  
  def destroy
    @d_meeting = Meeting.find_by(id: params[:id])
    @d_meeting.destroy
    redirect_to :back
  end
end
