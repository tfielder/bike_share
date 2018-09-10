class User < ApplicationRecord
  has_many :orders
  
  has_secure_password

  enum role: {default: 0, admin: 1}

  validates_presence_of :name
  validates :email, presence: true, uniqueness: true
end
