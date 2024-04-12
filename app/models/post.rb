class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments

  def increment_likes_counter
    self.likes_counter += 1
    save
  end
end
