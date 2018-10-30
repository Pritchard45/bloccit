class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  before_save { self.email = email.downcase if email.present? }
  before_save {
    name_arr = []
    name.to_s.split.each do |n|
      name_arr << n.capitalize
    end
    self.name = name_arr.join(" ")
  }


  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, presence: true, length: { minimum: 6 }, if: -> { password_digest.nil? }
  validates :password, length: { minimum: 6 }, allow_blank: true

   validates :email,
             presence: true,
             uniqueness: { case_sensitive: true },
             length: { minimum: 3, maximum: 254 }


   has_secure_password
 end
