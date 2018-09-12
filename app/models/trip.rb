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

    def self.percip_data(first_dig, second_dig)
      {high: percip_high(first_dig), low: percip_low(first_dig), first_avg: percip_avg_fh(first_dig), second_avg: percip_avg_sh(first_dig, second_dig)}
    end

    def self.max_temp_high(first_dig)
      date_counts = self.select(:start_date).joins("INNER JOIN conditions
                                  ON trips.start_date = conditions.date
                                  WHERE max_temp
                                  BETWEEN #{first_dig}0.0 AND #{first_dig}9.9"
                                ).group(:start_date).count
      if date_counts.count > 0
        date_counts.max_by{ |k,v| v }[1].to_f
      else
        date_counts.count.to_f
      end
    end

    def self.max_temp_low(first_dig)
      date_counts = self.select(:start_date).joins("INNER JOIN conditions
                                  ON trips.start_date = conditions.date
                                  WHERE max_temp
                                  BETWEEN #{first_dig}0.0 AND #{first_dig}9.9"
                                ).group(:start_date).count
      if date_counts.count > 0
        date_counts.min_by{ |k,v| v }[1].to_f
      else
        date_counts.count.to_f
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
        trip_total.to_f / all_count.size.to_f
      else
        trip_total.to_f
      end
    end

    def precip_high(first_dig)
      date_counts = self.select(:start_date).joins("INNER JOIN conditions
                                                    ON trips.start_date = conditions.date
                                                    WHERE precip
                                                    BETWEEN 0.0 AND 0.5").group(:start_date)
      if date_counts.count > 0
        date_counts.max_by{ |k,v| v }[1].to_f
      else
        date_counts.count.to_f
      end
    end

    def precip_low(first_dig)
      date_counts = self.select(:start_date).joins("INNER JOIN conditions
                                                    ON trips.start_date = conditions.date
                                                    WHERE precip
                                                    BETWEEN 0.0 AND 0.5").group(:start_date)
      if date_counts.count > 0
        date_counts.max_by{ |k,v| v }[1].to_f
      else
        date_counts.count.to_f
      end
    end

    def precip_avg_fh(first_dig)
      all_count = self.select(:start_date).joins("INNER JOIN conditions
                                                  ON trips.start_date = conditions.date
                                                  WHERE percip
                                                  BETWEEN #{first_dig}.0 AND #{first_dig}.5"
                                                ).group(:start_date).count

      trip_total = 0
      all_count.each do |date, _count|
        trip_total += all_count[date]
      end
      if all_count.size > 0
        trip_total.to_f / all_count.size.to_f
      else
        trip_total.to_f
      end
    end

    def precip_avg_sh(first_dig, second_dig)
      all_count = self.select(:start_date).joins("INNER JOIN conditions
                                                  ON trips.start_date = conditions.date
                                                  WHERE percip
                                                  BETWEEN #{first_dig}.5 AND #{second_dig}.0"
                                                ).group(:start_date).count

      trip_total = 0
      all_count.each do |date, _count|
        trip_total += all_count[date]
      end
      if all_count.size > 0
        trip_total.to_f / all_count.size.to_f
      else
        trip_total.to_f
      end
    end
end
