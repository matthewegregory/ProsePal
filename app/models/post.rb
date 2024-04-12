class Post < ApplicationRecord
  belongs_to :user
  has_many :likes

  def increment_likes_counter
    self.likes_counter += 1
    save
  end
end
