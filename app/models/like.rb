class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def updates_likes_count
    post.increment!(:likes_count)
  end
end
