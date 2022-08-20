class AddDefaultValue < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :comments_count
    remove_column :posts, :likes_count
    remove_column :users, :posts_count
    add_column :posts, :comments_count, :integer, default: 0
    add_column :posts, :likes_count, :integer, default: 0
    add_column :users, :posts_count, :integer, default: 0
  end
end
