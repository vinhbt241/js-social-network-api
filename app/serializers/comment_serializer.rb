class CommentSerializer
  include JSONAPI::Serializer
  attributes :id, :content, :post_id, :user_id, :serializer_user, :created_at, :updated_at
end
