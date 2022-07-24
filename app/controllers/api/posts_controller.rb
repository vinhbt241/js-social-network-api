class Api::PostsController < ApplicationController
  def comments 
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc)

    @comments = @comments.map do |comment|
      CommentSerializer.new(comment).serializable_hash[:data][:attributes]
    end

    render json: @comments
  end

  def likes 
    @post =  Post.find(params[:id])
    @likes = @post.likes.order(created_at: :desc)

    @likes = @likes.map do |like|
      LikeSerializer.new(like).serializable_hash[:data][:attributes]
    end

    render json: @likes
  end

  def create 
    @post = Post.new(post_params)

    if @post.save 
      render json: @post, status: :created
    else 
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private 

  def post_params 
    params.require(:post).permit(:content, :user_id, :image)
  end
end
