class AddLikesCounterToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :likes_counter, :integer, default: 0
  end
end
