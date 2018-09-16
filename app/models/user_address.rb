class UserAddress < ApplicationRecord
belongs_to :user
belongs_to :address

validates_presence_of :address
end
