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

  def self.most_rides
    Station.select("name, count(trips.start_station_id) as count").joins("JOIN trips ON stations.id = trips.start_station_id").group(:n
ame).order("count(trips.start_station_id) desc").limit(1).first.count #returns 32
  end
#   SELECT name, count(start_station_id)
# FROM stations
# INNER JOIN trips ON stations.id = trips.start_station_id
# GROUP BY stations.name
# ORDER BY count desc
# LIMIT 1;
end
