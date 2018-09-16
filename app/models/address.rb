class Address < ApplicationRecord
has_many :user_addresses
has_many :users, through: :user_addresses
validates_presence_of :address
end
