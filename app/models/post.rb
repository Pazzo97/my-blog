class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  def updates_posts_count
    user.increment!(:posts_count)
  end

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
