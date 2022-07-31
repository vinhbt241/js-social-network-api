class Api::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  def show 
    @user = User.find(params[:id])

    render json: UserSerializer.new(@user).serializable_hash[:data][:attributes]
  end

  def create 
    name = params[:name]
    email = params[:email]
    password = params[:password]
    password_confirmation = params[:password_confirmation]

    new_user = User.new(
      name: name, 
      is_online: true,
      email: email, 
      password: password, 
      password_confirmation: password_confirmation
    )

    if new_user.save!
      token = jwt_encode(user_id: new_user.id)
      render json: { token: token, user: UserSerializer.new(new_user).serializable_hash[:data][:attributes] }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
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

  def update_avatar 

  end

  def update_background_image 
    
  end

  def update_name 
    user = User.find(params[:user_id])
    new_name = params[:name]

    user.name = new_name 

    if user.save!
      render json: {message: "username updated"}, status: :ok 
    else 
      render json: { error: "can't process update" }, status: :bad_request
    end
  end

  def update_password 
    user = User.find(params[:user_id])
    new_password = params[:password]

    user.password = new_password 

    if user.save!
      render json: {message: "password updated"}, status: :ok 
    else 
      render status: :unauthorized
    end
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
