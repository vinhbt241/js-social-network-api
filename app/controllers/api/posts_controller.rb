class Api::PostsController < ApplicationController
  def comments 
    @post = Post.find(params[:id])
    @comments = @post.comments.order(:created_at)

    render json: @comments.to_json(include: [:user])
  end
end
