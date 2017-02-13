class User < ActiveRecord::Base
  
  has_secure_password 
  
  validates :email, presence: true
  validates :password_digest, presence: true
  validates :email, uniqueness: true
  
  has_many :links
end
