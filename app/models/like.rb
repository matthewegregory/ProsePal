class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, uniqueness: { scope: :post_id }

  # Increment the likes counter of the associated post
  def update_likes_counter
    post.increment!(:likes_counter)
  rescue StandardError => e
    # Handle any errors that might occur during the increment operation
    Rails.logger.error("Error updating likes counter: #{e.message}")
    errors.add(:base, "Unable to update likes counter")
    false
  end
end
