require 'csv'
require './app/models/trip.rb'
require './app/models/station.rb'
require './app/models/condition.rb'
require 'date'
# require './app/models/status.rb'

class Seed
  OPTIONS = {headers: true, header_converters: :symbol}

  def self.start
    clear_existing_data
    seed_stations
    # seed_statuses
    seed_weather
    seed_trips
  end

  def self.clear_existing_data
    Station.destroy_all
    # Status.destroy_all
    Trip.destroy_all
    Condition.destroy_all
  end

  def self.seed_stations
    stations = read_stations
    stations.each do |station|
      station_hash = {name: station[:name],
                      dock_count: station[:dock_count],
                      city: station[:city],
                      installation_date: Date.strptime(station[:installation_date], '%m/%d/%Y'),
                      id: station[:id]
                    }
      station = Station.create!(station_hash)
      puts "Created #{station.name}"
    end
    puts "Created all stations."
    ActiveRecord::Base.connection.reset_pk_sequence!('stations')
  end

  def self.read_stations
    @stations = []
    CSV.foreach(File.join('db', 'csv', 'station.csv'), OPTIONS) do |station|
      @stations << station
    end
    @stations
  end

  def self.seed_trips
    trips = read_trips
    trips.each do |trip|
      trip_hash = { duration: trip[:duration],
                    start_date: Date.strptime(trip[:start_date], '%m/%d/%Y'),
                    start_station_id: trip[:start_station_id],
                    end_date: Date.strptime(trip[:end_date], '%m/%d/%Y'),
                    end_station_id: trip[:end_station_id],
                    zip_code: trip[:zip_code],
                    subscription_type: trip[:subscription_type],
                    bike_id: trip[:bike_id],
                    id: trip[:id]
                    }
        if Station.find_by_id(trip[:start_station_id]) && Station.find_by_id(trip[:end_station_id]) && trip[:zip_code]
          Trip.create!(trip_hash)
          puts "Created trip!"
        else
          puts "Skipped trip!"
        end
        ActiveRecord::Base.connection.reset_pk_sequence!('trips')
      end
    puts "Created all trips."
  end

  def self.read_trips
    @trips = []
    CSV.foreach(File.join('db', 'csv', 'small_trip.csv'), OPTIONS) do |trip|
      @trips << trip
    end
    @trips
  end

  def self.seed_weather
    weathers = read_weather
    weathers.each do |weather|
      weather_hash = {
                    date: Date.strptime(weather[:date], '%m/%d/%Y'),
                    max_temp: weather[:max_temperature_f].to_f,
                    mean_temp: weather[:mean_temperature_f].to_f,
                    min_temp: weather[:min_temperature_f].to_f,
                    mean_humidity: weather[:mean_humidity].to_f,
                    mean_visibility: weather[:mean_visibility_miles].to_f,
                    mean_wind_speed: weather[:mean_wind_speed_mph].to_f,
                    precip: weather[:precipitation_inches].to_f
                  }
      if
        weather = Condition.create!(weather_hash)
        puts "Created condition"
      else
        puts "Skipped condition!"
      end
    end
    puts "Created all weather."
    ActiveRecord::Base.connection.reset_pk_sequence!('conditions')
  end

  def self.read_weather
    @weathers = []
    CSV.foreach(File.join('db', 'csv', 'small_weather.csv'), OPTIONS) do |weather|
      @weathers << weather
    end
    @weathers
  end
end

Seed.start

Accessory.create!( image: "https://s3files.core77.com/blog/images/lead_n_spotlight/lead_small_25827_.jpg",
                   title: "Screaming",
                   description: "Anyone there?",
                   price: 13.35
                )
puts "Accessory Created!"
Accessory.create!( image: "https://www.marxfoods.com/images/Blood-Oranges-Wholesale_BloodOranges-1.jpg?resizeid=13&resizeh=200&resizew=200",
                   title: "Being Asleep",
                   description: "Eternal Slumber",
                   price: 3.50
                )
puts "Accessory Created!"
Accessory.create!( image: "https://www.rockitpro.com/wp-content/uploads/letyougo-thumbnail.jpg",
                   title: "Talking To A Dead Relative",
                   description: "The price here isn't money",
                   price: 0.05
                )
puts "Accessory Created!"
Accessory.create!( image: "http://www.plantic.com.au/Sustainability/Rubbish03.jpg",
                   title: "Most Of The Earths Trash",
                   description: "Might be some cool stuff in there!",
                   price: 87.35
                )
puts "Accessory Created!"
Accessory.create!( image: "https://i.kym-cdn.com/photos/images/masonry/000/138/153/voldemort-120-thumb-120x120-34926.jpg",
                   title: "Voldemort",
                   description: "Noseless Racist Wizard",
                   price: 48.50
                )
puts "Accessory Created!"
Accessory.create!( image: "https://dehayf5mhw1h7.cloudfront.net/wp-content/uploads/sites/183/2016/03/14125222/fatal-accident1-200x200.jpg",
                   title: "Fatal Accident",
                   description: "Garunteed Delivery Within 30 Days",
                   price: 115.00
                )
puts "Accessory Created!"
Accessory.create!( image: "https://i5.walmartimages.com/asr/bb274856-013b-47fe-9e40-1fc8f2683e65_1.269d1a4b584e0b6ca9d766a55a4acac3.jpeg?odnWidth=200&odnHeight=200&odnBg=ffffff",
                   title: "Sour Cream",
                   description: "Pure...Natural",
                   price: 4.05
                )
puts "Accessory Created!"
Accessory.create!( image: "https://media.luggagepros.com/media/catalog/product/cache/1/image/200x200/9df78eab33525d08d6e5fb8d27136e95/3/7/37813-106518_180726145812.jpg",
                   title: "SpaceJam Back Pack",
                   description: "Just... A SpaceJam BackPack",
                   price: 38.00
                )
puts "Accessory Created!"
Accessory.create!( image: "http://www.metal-temple.com/uploads/catalogues/ecnephias-the-sad-wonder-of-the-sun.jpg",
                   title: "Pure Unadulterated Terror",
                   description: "NOT a good time.",
                   price: 26.00
                )
puts "Accessory Created!"
Accessory.create!( image: "http://iplaybaby.com/media/catalog/product/cache/1/small_image/200x200/9df78eab33525d08d6e5fb8d27136e95/1/4/144300-silicone_cup-aqua.jpg",
                   title: "Baby Cup",
                   description: "Has two handles because babies are too dumb for just one handle, ha, stupid baby.",
                   price: 13.35
                )
puts "Accessory Created!"
Accessory.create!( image: "https://i-cdn.phonearena.com//images/article/78286-image/Kanye-West-announced-a-gorgeous-video-game-about-his-mother-ascending-to-Heaven.jpg",
                   title: "Salvation",
                   description: "Eternal Happiness",
                   price: 6000.00
                )
puts "Accessory Created!"
Accessory.create!( image: "https://www.adorama.com/images/product/dgpatlagcs.jpg",
                   title: "Guitar",
                   description: "Just a guitar",
                   price: 120.00
                )
puts "Accessory Created!"
puts "Accessories Created!"
ActiveRecord::Base.connection.reset_pk_sequence!('accessories')

User.create!( name: "Autumn",
              email: "autumn@autumn.com",
              password: "123",
              password_confirmation: "123",
              role: 1
            )
puts "User Created!"
User.create!( name: "Maria",
              email: "maria@maria.com",
              password: "123",
              password_confirmation: "123",
              role: 1
            )
puts "Admin Created!"
User.create!( name: "Tim",
              email: "tim@tim.com",
              password: "123",
              password_confirmation: "123",
              role: 1
            )
puts "User Created!"
User.create!( name: "Ben",
              email: "ben1@ben1.com",
              password: "123",
              password_confirmation: "123",
              role: 1
            )
puts "User Created!"
User.create!( name: "test",
              email: "test@test",
              password: "test",
              password_confirmation: "test",
              role: 0
            )
puts "User Created!"
puts "Users Created!"
ActiveRecord::Base.connection.reset_pk_sequence!('users')
