class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, uniqueness: true, length: { in: 5..18 }
  validates :bio, length: { in: 20..200 }

  def self.search(query)
    where("username LIKE ? OR first_name LIKE ? OR last_name LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
