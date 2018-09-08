class Station < ApplicationRecord
  before_save :generate_slug

  has_many :trips

  def generate_slug
    self.slug = name.parameterize
  end
  
  def to_param
    slug
  end

end
