class Api::LikesController < ApplicationController
  def create 
    if Like.where(post_id: params[:post_id], user_id: params[:user_id]).empty? 
      Like.create(post_id: params[:post_id], user_id: params[:user_id])
    end
  end

  def destroy 
    @like = Like.find(params[:id])

    @like.destroy
  end
end
