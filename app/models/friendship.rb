class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: 'friend_id'
  scope :friends, -> { where("status = 'accepted'", true) }
  scope :not_friends, -> { where("status = 'accepted'", false) }

  def self.request(user, friend) 
    unless user == friend or Friendship.exists?(user_id: user.id, friend_id: friend.id)
      transaction do 
        create(user_id: user.id, friend_id: friend.id, status: "requested")

        f = Friendship.find_by(user_id: friend.id, friend_id: user.id, status: "declined")

        if f.nil?
          create(user_id: friend.id, friend_id: user.id, status: "pending" )
        else 
          f.status = "pending"
          f.save!
        end
      end
    end
  end

  def self.accept(user, friend)
    transaction do 
      accept_one_side(user, friend)
      accept_one_side(friend, user)
    end
  end

  def self.accept_one_side(user,friend)
    request = Friendship.find_by(user_id: user.id, friend_id: friend.id)
    request.status = 'accepted'
    request.save!
  end


  def self.decline(user, friend)
    request = Friendship.find_by(user_id: user.id, friend_id: friend.id, status: "requested")
    request.status = 'declined'
    request.save!

    Friendship.find_by(user_id: friend.id, friend_id: user.id, status: "pending").destroy
  end
end
