class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :send_favorite_emails

  private

  def send_favorite_emails
    post.favorites.each do |favorite|
      FavoriteMailer.new_post(favorite.user, post, self).deliver_now
  end
end
