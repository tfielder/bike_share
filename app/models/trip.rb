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

    belongs_to :condition

    def self.max_temp_high(first_dig)
      z = self.joins("INNER JOIN conditions ON trips.start_date = conditions.date WHERE max_temp BETWEEN #{first_dig}0.0 AND #{first_dig}9.9")
      l = z.group_by do |c|
        c.start_date
      end
      r = l.map do |key, value|
        value.count
      end.uniq
      r.max.to_f
    end

    def self.max_temp_low(first_dig)
      z = self.joins("INNER JOIN conditions ON trips.start_date = conditions.date WHERE max_temp BETWEEN #{first_dig}0.0 AND #{first_dig}9.9")
      l = z.group_by do |c|
        c.start_date
      end
      r = l.map do |key, value|
        value.count
      end.uniq
      r.min.to_f
    end

    def self.max_temp_avg(first_dig)
      all_trips_in_range = self.joins("INNER JOIN conditions ON trips.start_date = conditions.date WHERE max_temp BETWEEN #{first_dig}0.0 AND #{first_dig}9.9")
      trips_by_start_date = all_trips_in_range.group_by do |trip|
        trip.start_date
      end
      count_of_trips = trips_by_start_date.map do |key, value|
        value.count
      end.uniq
      if count_of_trips.count > 0
        count_of_trips.sum.to_f / count_of_trips.count.to_f
      else
        count_of_trips.count
      end
    end

end
