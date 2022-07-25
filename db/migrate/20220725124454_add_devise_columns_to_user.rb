class AddDeviseColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :email,                    default: "", null: false
      t.string :encrypted_password,       default: "", null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at 
      t.datetime :remember_created_at 
      t.integer :sign_in_count,           default: 0,  null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at 
      t.string :current_sign_in_ip 
      t.string :last_sign_in_ip 
    end

    add_index :users, [:email], name: "index_users_on_email", unique: true
    add_index :users, [:reset_password_token], name: "index_users_on_reset_password_token", unique: true
  end
end
