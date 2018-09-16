class Station < ApplicationRecord

   has_many :trips, class_name: "Trip", foreign_key: 'start_station_id'
   has_many :trips, class_name: "Trip", foreign_key: 'end_station_id'

  validates_presence_of :name, :dock_count, :city, :installation_date

  before_save :generate_slug

  has_many :trips

  def generate_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end

  def rides_started
    Trip.where(start_station_id: self.id).count
  end

  def rides_ended
    Trip.where(end_station_id: self.id).count
  end

  def frequent_destination
    station_hash = Trip.select("end_station_id, count(end_station_id)")
          .where(start_station_id: self.id)
          .group(:end_station_id)
          .order("count desc")
          .limit(1)
          .first
          .end_station_id

    Station.find_by_id(station_hash).name
  end

  def frequent_origination
    station_hash = Trip.select("start_station_id, count(start_station_id)")
          .where(end_station_id: self.id)
          .group(:start_station_id)
          .order("count desc")
          .limit(1)
          .first
          .start_station_id

    Station.find_by_id(station_hash).name
  end

  def most_trips
    Trip.select("start_date, count(start_date)")
          .where(start_station_id: self.id)
          .group(:start_date)
          .order("count desc")
          .limit(1)
          .first
          .start_date
  end

  def frequent_zip
    Trip.select("zip_code, count(zip_code)")
          .where(start_station_id: self.id)
          .group(:zip_code)
          .order("count desc")
          .limit(1)
          .first
          .zip_code
  end

  def frequent_bike_id
    Trip.select("bike_id, count(bike_id)")
          .where(start_station_id: self.id)
          .group(:bike_id)
          .order("count desc")
          .limit(1)
          .first
          .bike_id
  end

end
