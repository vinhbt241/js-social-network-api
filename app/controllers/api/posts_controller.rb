class Api::PostsController < ApplicationController
  def show  
    user = User.find(params[:id])
    @posts = user.posts 

    render json: @posts
  end
end
