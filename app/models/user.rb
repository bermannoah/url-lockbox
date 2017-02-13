class User < ApplicationRecord
  validates :email, presence: true
  validates :password_digest, presence: true
  validates :email, uniqueness: true
  
  has_many :links
end
