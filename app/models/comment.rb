class Comment < ApplicationRecord
  belongs_to :post 
  belongs_to :user

  def serializer_user 
    UserSerializer.new(user).serializable_hash[:data][:attributes]
  end
end
