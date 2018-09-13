class Trip < ApplicationRecord
  validates_presence_of :duration,
                        :start_date,
                        :end_date,
                        :bike_id,
                        :subscription_type,
                        :zip_code,
                        :start_station_id,
                        :end_station_id

    belongs_to :start_station, class_name: "Station"
    belongs_to :end_station, class_name: "Station"

  def self.average_duration
    average(:duration)
  end

  def self.longest_ride
    maximum(:duration)
  end

  def self.shortest_ride
    minimum(:duration)
  end

  def self.most_rides_start
    Station.select("name, count(trips.start_station_id) as count").joins("JOIN trips ON stations.id = trips.start_station_id").group(:name).order("count(trips.start_station_id) desc").limit(1).first#returns 32
  end

  def self.most_rides_end
    Station.select("name, count(trips.end_station_id) as count").joins("JOIN trips ON stations.id = trips.end_station_id").group(:name).order("count(trips.end_station_id) desc").limit(1).first
  end

  def monthly_breakdown
  end

  def self.user_subscription_breakdown
     Trip.select("subscription_type, count(subscription_type)").group("subscription_type").count("subscription_type")
  end

  def self.most_bike_rides
    select("bike_id, count(bike_id) as count").group(:bike_id).order("count(bike_id) desc").limit(1).first
  end

  def self.least_bike_rides
    select("bike_id, count(bike_id) as count").group(:bike_id).order("count(bike_id) asc").limit(1).first
  end

  def self.date_with_most_trips
    select("start_date, count(start_date) as count").group(:start_date).order("count(start_date) desc").limit(1).first
  end

  def self.date_with_least_trips
    select("start_date, count(start_date) as count").group(:start_date).order("count(start_date) asc").limit(1).first
  end
end
