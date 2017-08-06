class PostsController < ApplicationController
  #protect_from_forgery with: :exception
  before_action :authenticate_check, only: [:edit, :update, :destroy]
  before_action :user_signed_in
  
  def index
      @posts = Post.order("id DESC").paginate(:page => params[:page], :per_page => 7)
  end
  def show
      @post = Post.find(params[:id])
      @post.hits+=1
      @post.save
  end
  def new
  end
  def edit
      @post = Post.find(params[:id])
  end
  def create
      @post = Post.create(title: params[:title], content: params[:content], user_id: current_user.id)
      redirect_to @post
  end
  def update
    @post = Post.find(params[:id])
    @post.title = params[:title]
    @post.content = params[:content]
    if @post.save
      redirect_to root_path
    else
      render :edit
    end
  end
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def authenticate_check
    @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      redirect_to '/'
    end
  end
  
  def user_signed_in
    if current_user.nil?
      redirect_to new_session_path
    end
  end
end
