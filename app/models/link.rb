class Link < ActiveRecord::Base
  
  validates :title, presence: true
  validates :url, presence: true
  validates :url, :url => true
  validates :url, :url => {:no_local => true}

  belongs_to :user
end
