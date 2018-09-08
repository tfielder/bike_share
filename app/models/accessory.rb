class Accessory < ApplicationRecord
  validates_presence_of :title, :description, :price, :image
end
