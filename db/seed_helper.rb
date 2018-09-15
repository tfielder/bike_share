require 'csv'
# require './app/models/status.rb'

class SeedHelper
  OPTIONS = {headers: true, header_converters: :symbol}

  def self.start
    # seed_statuses
    read_trips
  end


  def self.read_trips
    @trips = []
    CSV.foreach(File.join('db', 'csv', 'trip.csv')) do |trip|
      @trips << trip
    end
    small_sample2 = @trips.sample(500)
    File.open("db/csv/small_trip.csv", "w") {|f| f.write(small_sample2.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join(""))}
  end

  def self.read_weather
    @weathers = []
    CSV.foreach(File.join('db', 'csv', 'weather.csv')) do |weather|
      @weathers << weather
    end
    small_sample = @weathers.sample(500)
    File.open("db/csv/small_weather.csv", "w") {|f| f.write(small_sample.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join(""))}
  end

end

SeedHelper.start
