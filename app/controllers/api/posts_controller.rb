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

  def create 
    @post = Post.new(post_params)

    if @post.save 
      render json: @post, status: :created, location: @post
    else 
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private 

  def post_params 
    params.require(:post).permit(:content, :user_id, :image)
  end
end
