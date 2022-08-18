class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, class_name: 'Post', foreign_key: :post_id

  after_save :updates_likes_count

  def updates_likes_count
    post.increment!(:likes_count)
  end
end
