class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friendships.map { |f| f.friend if f.status == 'confirmed' }.compact
  end

  def pending_friends
    friendships.map { |f| f.friend if f.status == 'pending' }.compact
  end

  def friend_requests
    inverse_friendships.map { |f| f.user if f.status == 'pending' }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.status = 'confirmed'
    friendship.save
  end

  def deny_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end

  def request_sent?(user)
    friendships.find { |f| (f.friend == user and f.status == 'pending') }
  end

  def request_recieved?(user)
    inverse_friendships.find { |f| (f.user == user and f.status == 'pending') }
  end
end
