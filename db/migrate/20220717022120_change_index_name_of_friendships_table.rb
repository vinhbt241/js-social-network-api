class ChangeIndexNameOfFriendshipsTable < ActiveRecord::Migration[7.0]
  def change
    remove_index :friendships, name: "index_friendships_on_user_id_and_friend_user_id"
    add_index(:friendships, [:user_id, :friend_id], :unique => true)
  end
end
