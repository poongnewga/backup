class LikesController < ApplicationController
  def like_toggle
    like = Like.find_by(user_id: current_user.id,
                        post_id: params[:id])

    if like.nil?
      Like.create(user_id: current_user.id,
                  post_id: params[:id])
    else
      like.destroy
    end
  end
end
