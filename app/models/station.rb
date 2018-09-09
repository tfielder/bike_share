class Station < ApplicationRecord

   has_many :trips, foreign_key: 'start_station_id', class_name: "Trip"
   has_many :trips, foreign_key: 'end_station_id', class_name: "Trip"

  validates_presence_of :name, :dock_count, :city, :installation_date

  before_save :generate_slug

  has_many :trips

  def generate_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end


end
