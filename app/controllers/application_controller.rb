class ApplicationController < ActionController::API
  include JsonWebToken 
  
  before_action :authenticate_request

  def authenticate_request 
    unless user_id_in_token? 
      render json: { error: 'unauthorized' }, status: :unauthorized
      return 
    end

    @current_user = User.find(auth_token[:user_id])

  rescue JWT::VerificationError, JWT::DecodeError
    render json: { error: 'unauthorized' }, status: :unauthorized
  end

  private

  def http_token 
    if request.headers["Authorization"].present?
      @http_token ||= request.headers["Authorization"].split(" ").last
    end
  end

  def auth_token 
    @auth_token ||= jwt_decode(http_token)
  end

  def user_id_in_token? 
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
