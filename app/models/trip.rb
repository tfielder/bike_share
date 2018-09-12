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

    def self.max_temp_data(first_dig)
      {high: max_temp_high(first_dig), low: max_temp_low(first_dig), avg: max_temp_avg(first_dig)}
    end

    def self.precip_data(first_num, second_num)
      {high: precip_high(first_num, second_num), low: precip_low(first_num, second_num), avg: precip_avg(first_num, second_num)}
    end

    def self.max_temp_high(first_dig)
      date_counts = self.select(:start_date).joins("INNER JOIN conditions
                                  ON trips.start_date = conditions.date
                                  WHERE max_temp
                                  BETWEEN #{first_dig}0.0 AND #{first_dig}9.9"
                                ).group(:start_date).count
      if date_counts.count > 0
        date_counts.max_by{ |k,v| v }[1].to_f.round(2)
      else
        date_counts.count.to_f.round(2)
      end
    end

    # Raw SQL for this query, can't figure out active record
    # SELECT start_date, COUNT(start_date)
    # FROM trips
    # INNER JOIN conditions ON conditions.date = trips.start_date
    # WHERE max_temp BETWEEN 60.0 AND 69.9
    # GROUP BY start_date
    # ORDER BY count desc
    # LIMIT 1
    def self.max_temp_low(first_dig)
      date_counts = self.select(:start_date).joins("INNER JOIN conditions
                                  ON trips.start_date = conditions.date
                                  WHERE max_temp
                                  BETWEEN #{first_dig}0.0 AND #{first_dig}9.9"
                                ).group(:start_date).count
      if date_counts.count > 0
        date_counts.min_by{ |k,v| v }[1].to_f.round(2)
      else
        date_counts.count.to_f.round(2)
      end
    end

    def self.max_temp_avg(first_dig)
      all_count = self.select(:start_date).joins("INNER JOIN conditions
                                                  ON trips.start_date = conditions.date
                                                  WHERE max_temp
                                                  BETWEEN #{first_dig}0.0 AND #{first_dig}9.9"
                                                ).group(:start_date).count

      trip_total = 0
      all_count.each do |date, _count|
        trip_total += all_count[date]
      end
      if all_count.size > 0
        (trip_total.to_f / all_count.size.to_f).round(2)
      else
        trip_total.to_f.round(2)
      end
    end

    # Raw SQL for this query, can't figure out active record
    # SELECT start_date, COUNT(start_date)
    # FROM trips
    # INNER JOIN conditions ON conditions.date = trips.start_date
    # WHERE precip BETWEEN 0.0 AND 0.4
    # GROUP BY start_date
    # ORDER BY count desc
    # LIMIT 1;
    def self.precip_high(first_f, second_f)
      date_counts = self.select(:start_date).joins("INNER JOIN conditions
                                                    ON trips.start_date = conditions.date
                                                    WHERE precip
                                                    BETWEEN #{first_f} AND #{second_f}"
                                                  ).group(:start_date).count
      if date_counts.count > 0
        (date_counts.max_by{ |k,v| v }[1].to_f).round(2)
      else
        date_counts.count.to_f.round(2)
      end
    end

    def self.precip_low(first_f, second_f)
      date_counts = self.select(:start_date).joins("INNER JOIN conditions
                                                    ON trips.start_date = conditions.date
                                                    WHERE precip
                                                    BETWEEN #{first_f} AND #{second_f}"
                                                  ).group(:start_date).count
      if date_counts.count > 0
        date_counts.min_by{ |k,v| v }[1].to_f.round(2)
      else
        date_counts.count.to_f.round(2)
      end
    end

    def self.precip_avg(first_f, second_f)
      all_count = self.select(:start_date).joins("INNER JOIN conditions
                                                  ON trips.start_date = conditions.date
                                                  WHERE precip
                                                  BETWEEN #{first_f} AND #{second_f}"
                                                ).group(:start_date).count

      trip_total = 0
      all_count.each do |date, _count|
        trip_total += all_count[date]
      end
      if all_count.size > 0
        (trip_total.to_f / all_count.size.to_f).round(2)
      else
        trip_total.to_f.round(2)
      end
    end
end
