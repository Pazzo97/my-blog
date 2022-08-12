class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { minimum: 3, maximum: 250 }
  validates :comments_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_post_counter
    author.increment!(:posts_counter)
  end

  def most_recent_comments
    comments.order(created_at: :DESC).limit(5)
  end
end
