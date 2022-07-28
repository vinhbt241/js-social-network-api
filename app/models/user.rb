class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  
  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where "status = 'accepted'" }, through: :friendships
  has_many :requested_friends, -> { where "status = 'requested'" }, through: :friendships, source: :friend
  has_many :pending_friends, -> { where "status = 'pending'" }, through: :friendships, source: :friend
  has_many :declined_friends, -> { where "status = 'declined'"}, through: :friendships, source: :friend

  has_one_attached :avatar 
  has_one_attached :background_image

  def avatar_url 
    Rails.application.routes.url_helpers.url_for(avatar) if avatar.attached?
  end

  def background_image_url 
    Rails.application.routes.url_helpers.url_for(background_image) if background_image.attached?
  end
end
