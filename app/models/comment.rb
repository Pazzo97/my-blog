class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def updates_comments_count
    post.increment!(:comments_count)
  end
end
