class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_one_attached :avatar 
  has_one_attached :background_image

  def avatar_url 
    Rails.application.routes.url_helpers.url_for(avatar) if avatar.attached?
  end

  def background_image_url 
    Rails.application.routes.url_helpers.url_for(background_image) if background_image.attached?
  end
end
