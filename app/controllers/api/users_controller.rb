class Api::UsersController < ApplicationController
  def show 
    @user = User.find(params[:id])

    render json: @user
  end

  def user_posts 
    @user = User.find(params[:id])

    @posts = @user.posts

    @posts = @posts.map do |post|
      PostSerializer.new(post).serializable_hash[:data][:attributes]
    end

    @posts = @posts.sort_by { |post| post["created_at"] }

    render json: @posts
  end

  def user_and_friends_posts 
    @user = User.find(params[:id])
    @posts = []

    @posts.push(@user.posts)
    
    @user.friends.each do |friend| 
      @posts.push(friend.posts)
    end

    @posts = @posts.flatten

    @posts = @posts.map do |post|
      PostSerializer.new(post).serializable_hash[:data][:attributes]
    end

    @posts = @posts.sort_by { |post| post["created_at"] }

    render json: @posts
  end

  def friends 
    @user = User.find(params[:id])

    render json: @user.friends
  end
end
