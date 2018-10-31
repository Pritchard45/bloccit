class Post < ApplicationRecord
  belongs_to :topic, optional: true
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy

  default_scope { order('created_at DESC') }
  #for assignment
  scope :ordered_by_title, -> { order('title DESC') }
  # for assignment
  scope :ordered_by_reverse_created_at, -> { reorder('created_at ASC') }

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: { minimum: 20}, presence: true
  validates :topic, presence: false
  validates :user, presence: false
end
