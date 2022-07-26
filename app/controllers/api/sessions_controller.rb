class Api::SessionsController < ApplicationController
  def create 
    user = User.find_by_email(params[:email])

    if user&.valid_password?(params[:password]) 
      token = jwt_encode(user_id: user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def destroy 

  end
end
