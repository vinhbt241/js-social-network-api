class Api::UsersController < ApplicationController
  def show 
    @user = User.find(params[:id])

    render json: @user
  end

  def friends 
    @user = User.find(params[:user_id])

    render json: @user.friends
  end
end
