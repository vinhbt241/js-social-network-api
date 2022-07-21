class PostSerializer
  include JSONAPI::Serializer
  attributes :id, :content, :user_id, :image_url, :created_at, :updated_at, :num_likes, :num_comments, :serializer_user
end
