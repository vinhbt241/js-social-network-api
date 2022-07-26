class Api::SessionsController < ApplicationController
  skip_before_action :authenticate_request
  
  def create 
    user = User.find_by_email(params[:email])

    if user&.valid_password?(params[:password]) 
      token = jwt_encode(user_id: user.id)
      render json: { token: token, user: UserSerializer.new(user).serializable_hash[:data][:attributes] }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
