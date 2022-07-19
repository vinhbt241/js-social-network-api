class Api::PostsController < ApplicationController
  def comments 
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc)

    render json: @comments.to_json(include: [:user])
  end

  def likes 
    @post =  Post.find(params[:id])
    @likes = @post.likes.order(created_at: :desc)

    render json: @likes.to_json(include: [:user])
  end
end
