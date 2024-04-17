class AddForeignKeysToPostTagsAndTags < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :posts_tags, :posts, column: :post_id
    add_foreign_key :posts_tags, :tags, column: :tag_id

    # add_foreign_key :tags, :posts_tags, column: :tag_id
  end
end
