class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :is_online, :avatar_url, :background_image_url, :created_at, :updated_at
end
