class Api::UsersController < ApplicationController
  def show 
    @user = User.find(params[:id])

    render json: UserSerializer.new(@user).serializable_hash[:data][:attributes]
  end

  def user_posts 
    @user = User.find(params[:id])

    @posts = @user.posts

    @posts = @posts.sort_by { |post| post["created_at"] }
    @posts = @posts.reverse

    @posts = @posts.map do |post|
      PostSerializer.new(post).serializable_hash[:data][:attributes]
    end

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

    @posts = @posts.sort_by { |post| post["created_at"] }
    @posts = @posts.reverse

    @posts = @posts.map do |post|
      PostSerializer.new(post).serializable_hash[:data][:attributes]
    end


    render json: @posts
  end

  def friends 
    @user = User.find(params[:id])

    @friends = @user.friends 

    @friends = @friends.map do |friend|
      UserSerializer.new(friend).serializable_hash[:data][:attributes]
    end

    render json: @friends
  end

  def pending_friends 
    @user = User.find(params[:id])

    @pending_friends = @user.pending_friends 

    @pending_friends = @pending_friends.map do |pending_friend|
      UserSerializer.new(pending_friend).serializable_hash[:data][:attributes]
    end

    render json: @pending_friends
  end

  def potential_friends 
    @user = User.find(params[:id])

    @potential_friends = User.all.filter do |potential_friend|
      unless potential_friend_associated_with_user?(@user, potential_friend)
        true 
      else
        false
      end
    end

    @potential_friends = @potential_friends.map do |potential_friend|
      UserSerializer.new(potential_friend).serializable_hash[:data][:attributes]
    end

    render json: @potential_friends
  end

  def send_friend_request 
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])

    Friendship.request(@user, @friend)
  end

  def accept_pending_request 
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])

    Friendship.accept(@user, @friend)
  end

  def decline_friend_request 
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])

    Friendship.decline(@friend, @user)
  end

  private 

  def potential_friend_associated_with_user?(user, friend) 
    (friend.id == user.id) or
    (user.friends.include?(friend)) or
    (user.requested_friends.include?(friend)) or
    (user.pending_friends.include?(friend)) or
    (user.declined_friends.include?(friend))
  end
end
