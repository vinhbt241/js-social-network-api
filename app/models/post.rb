class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :image

  def image_url 
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end

  def num_likes 
    likes.count 
  end

  def num_comments 
    comments.count
  end

  def serializer_user 
    UserSerializer.new(user).serializable_hash[:data][:attributes]
  end
end
