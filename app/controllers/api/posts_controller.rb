class Api::PostsController < ApplicationController
  def comments 
    @posts = Post.find(params[:id])

    render json: @posts.comments.to_json(include: [:user])
  end
end
