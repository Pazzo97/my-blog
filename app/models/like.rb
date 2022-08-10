class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def updates_likes_count
    post.increment!(:likes_count)
  end
end
