class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_count, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  after_initialize :init

  def init
    self.posts_count ||= 0 # will set the default value only if it's nil
  end

  def most_recent_posts
    posts.order(created_at: :DESC).limit(3)
  end
end
