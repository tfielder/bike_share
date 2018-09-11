class Accessory < ApplicationRecord
  validates_presence_of :title, :description, :price, :image
  validates :title, uniqueness: true

  before_save :generate_slug

  has_many :order_accessories
  has_many :orders, through: :order_accessories

  def generate_slug
    self.slug = title.parameterize
  end

  def to_param
    slug
  end
end
