class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, class_name: 'Comment'
  has_many :likes, class_name: 'Like'

  validates :title, presence: true, length: { minimum: 3, maximum: 250 }
  validates :comments_count, :likes_count, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  # after_initialize :init

  # def init
  #   self.comments_count ||= 0 # will set the default value only if it's nil
  #   self.likes_count ||= 0 # will set the default value only if it's nil
  # end

  after_save :update_post_counter

  def update_post_counter
    author.increment!(:posts_count)
  end

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
