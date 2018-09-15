class Condition < ApplicationRecord
  validates_presence_of :date
  validates_presence_of :max_temp
  validates_presence_of :mean_temp
  validates_presence_of :min_temp
  validates_presence_of :mean_humidity
  validates_presence_of :mean_visibility
  validates_presence_of :mean_wind_speed
  validates_presence_of :precip

  def self.condition_on_date(date)
    where(date: date)
  end

end
