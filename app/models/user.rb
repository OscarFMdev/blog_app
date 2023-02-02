class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id

  has_one_attached :photo

  validates :name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :photo, presence: true
  validates :bio, presence: true, length: { minimum: 3, maximum: 140 }
  validates :posts_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def last_three_posts
    posts.limit(3).order(created_at: :desc)
  end
end
