class Post < ApplicationRecord
  belongs_to :topic, optional: true
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  after_create :create_vote
  after_create :create_favorite

  default_scope { order('rank DESC') }
  #for assignment
  scope :ordered_by_title, -> { order('title DESC') }
  # for assignment
  scope :ordered_by_reverse_created_at, -> { reorder('created_at ASC') }

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: { minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

  def create_vote
    user.votes.create(value: 1, post: self)
  end

  private

  def create_favorite
    user.favorites.create(post: self)
  end

   after_create :send_favorite_emails

   private

   def send_favorite_emails
     post.favorites.each do |favorite|
       FavoriteMailer.new_post(favorite.user, post, self).deliver_now
   end
end
