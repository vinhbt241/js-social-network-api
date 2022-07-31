class AddFriendRelationshipForUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_online, :boolean

    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end

    add_index(:friendships, [:user_id, :friend_id], :unique => true)
    add_index(:friendships, [:friend_id, :user_id], :unique => true)
    
  end
end
