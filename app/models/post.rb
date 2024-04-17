class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts_tags, dependent: :destroy
  has_many :tags, through: :posts_tags

  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true

  # attr_accessor :tag_list

  # after_save :assign_tags

  validates :text, length: { in: 10..500 }
  validates :title, length: { in: 5..30 }

  def increment_likes_counter
    self.likes_counter += 1
    save
  end

  def increment_comments_counter
    self.comments_counter += 1
    save
  end

  def tag_list=(tags_string_or_array)
    if tags_string_or_array.is_a?(String)
      tag_names = tags_string_or_array.split(",").collect(&:strip).map(&:downcase).uniq
    elsif tags_string_or_array.is_a?(Array)
      tag_names = tags_string_or_array.map(&:strip).map(&:downcase).uniq
    end

    self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name) }
  end

  # private

  # def assign_tags(tag_names)
  #   tag_names.each do |name|
  #     tag = Tag.find_or_create_by(name: name)
  #     self.tags << tag
  #   end
  # end
end
