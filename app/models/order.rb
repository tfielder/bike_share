class Order < ApplicationRecord
  belongs_to :user
  has_many :order_accessories
  has_many :accessories, through: :order_accessories



  def accessory_count
    accessory_hash = self.accessories.group(:id).count
    accessory_hash.map do |id, count|
      [Accessory.find(id), count]
    end.to_h
  end

  def total_price
    x = 0
    accessory_count.each do |accessory, count|
      x += accessory.price * count
    end
    x
  end
end
