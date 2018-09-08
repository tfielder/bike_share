class Station < ApplicationRecord
  has_many :trips, foreign_key: 'start_station_id', class_name: "Trip"
  has_many :trips, foreign_key: 'end_station_id', class_name: "Trip"

end
