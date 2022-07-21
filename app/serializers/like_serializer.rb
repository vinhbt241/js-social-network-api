class LikeSerializer
  include JSONAPI::Serializer
  attributes :id, :post_id, :user_id, :serializer_user, :created_at, :updated_at
end
