class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true

  after_create :increment_comments_counter

  validates :text, presence: true

  private

  def increment_comments_counter
    post.increment_comments_counter
  end
end
