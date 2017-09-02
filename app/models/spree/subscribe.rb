class Spree::Subscribe < ApplicationRecord
  validates :email, presence: true, uniqueness: {case_sensitive: false},
    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Email not validated"}
end
