class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_many :likes, as: :likeable, dependent: :destroy

  after_create :increment_post_comments_counter

  def update_comments_counter
    post.increment!(:comments_counter)
  end

  private

  def increment_post_comments_counter
    post.increment!(:comments_counter)
  end
end
