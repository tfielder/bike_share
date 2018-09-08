class Accessory < ApplicationRecord
  validates_presence_of :title, :description, :price, :image

  before_save :generate_slug

  def generate_slug
    self.slug = title.parameterize
  end

  def to_param
    slug
  end
end
