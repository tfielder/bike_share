require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:duration)}
    it {should validate_presence_of(:start_date)}
    it {should validate_presence_of(:end_date)}
    it {should validate_presence_of(:bike_id)}
    it {should validate_presence_of(:subscription_type)}
    it {should validate_presence_of(:start_station_id)}
    it {should validate_presence_of(:end_station_id)}
  end
  describe 'relationships' do
    it {should belong_to(:start_station)}
    it {should belong_to(:end_station)}
  end
  describe 'methods' do
    it 'should return the average duration' do
      station_1 = Station.create(name:"1 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      station_2 = Station.create(name:"2 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))

      trip_1 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_2 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_3 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_4 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )

      expect(Trip.average_duration).to eq(12)
    end
    it 'should return the longest and shortest ride' do
      station_1 = Station.create(name:"1 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      station_2 = Station.create(name:"2 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))

      trip_1 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_2 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )

      expect(Trip.longest_ride).to eq(42)
      expect(Trip.shortest_ride).to eq(2)
    end
    it 'should return the starting station and ending station with the most rides' do
      station_1 = Station.create(name:"1 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      station_2 = Station.create(name:"2 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      station_3 = Station.create(name:"3 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      station_4 = Station.create(name:"4 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))

      trip_1 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_2 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_3 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_3, end_date: ("09/01/2018"), end_station:station_4,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )

      expect(Trip.most_rides_start.name).to eq(station_1.name)
      expect(Trip.most_rides_start.count).to eq(2)
      expect(Trip.most_rides_end.name).to eq(station_2.name)
      expect(Trip.most_rides_end.count).to eq(2)
    end
    it 'should return the bike with the most bike rides and least bike rides' do
      station_1 = Station.create(name:"1 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      station_2 = Station.create(name:"2 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      trip_1 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_2 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_3 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 4, subscription_type:"Subsciber", zip_code: 94127 )
      trip_4 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )

      expect(Trip.most_bike_rides.bike_id).to eq(2)
      expect(Trip.least_bike_rides.bike_id).to eq(4)
    end
    it 'should return the date with the most trips and the least trips' do
      station_1 = Station.create(name:"1 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      station_2 = Station.create(name:"2 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      trip_1 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_2 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_3 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 4, subscription_type:"Subsciber", zip_code: 94127 )
      trip_4 = Trip.create(duration: 2, start_date: ("10/01/2018"), start_station:station_1, end_date: ("10/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )

      expect(Trip.date_with_most_trips.start_date).to eq("09/01/2018")
      expect(Trip.date_with_most_trips.count).to eq(3)
      expect(Trip.date_with_least_trips.start_date).to eq("10/01/2018")
      expect(Trip.date_with_least_trips.count).to eq(1)
    end
    it "should return user subscription type breakdown" do
      station_1 = Station.create(name:"1 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      station_2 = Station.create(name:"2 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      trip_1 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subscriber", zip_code: 94127 )
      trip_2 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subscriber", zip_code: 94127 )
      trip_3 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 4, subscription_type:"Customer", zip_code: 94127 )
      trip_4 = Trip.create(duration: 2, start_date: ("10/01/2018"), start_station:station_1, end_date: ("10/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Customer", zip_code: 94127 )
      expect(Trip.user_subscription_breakdown["Subscriber"]).to eq(2)
      expect(Trip.user_subscription_breakdown["Customer"]).to eq(2)
      expect(Trip.user_subscription_breakdown["Subscriber"].to_f/Trip.all.count * 100).to eq(50)
      expect(Trip.user_subscription_breakdown["Customer"].to_f/Trip.all.count * 100).to eq(50)
    end
    it 'should return the monthly breakdown of trips' do
    station_1 = Station.create(name:"1 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
    station_2 = Station.create(name:"2 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
    trip_1 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subscriber", zip_code: 94127 )
    trip_2 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subscriber", zip_code: 94127 )
    trip_3 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 4, subscription_type:"Customer", zip_code: 94127 )
    trip_4 = Trip.create(duration: 2, start_date: ("9/01/2018"), start_station:station_1, end_date: ("10/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Customer", zip_code: 94127 )
    expect(Trip.monthly_breakdown[0].count).to eq(4)
    end
    it "::trips_high, ::trips_low, ::trips_avg" do
      station_1 = Station.create(name:"1 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      station_2 = Station.create(name:"2 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      trip_1 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_2 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_3 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      trip_4 = Trip.create(duration: 2, start_date: ("09/02/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      condition_1 = Condition.create(date:"09/01/2018", max_temp:80.0, mean_temp:75.0, min_temp:40.0, mean_humidity:12.5, mean_visibility:10.0, mean_wind_speed:10.0, precip:1.0)
      condition_2 = Condition.create(date:"09/02/2018", max_temp:81.0, mean_temp:76.0, min_temp:41.0, mean_humidity:13.0, mean_visibility:12.0, mean_wind_speed:5.0, precip:0.0)

      expected_1 = Trip.trips_low("max_temp", 80, 89.9)
      expected_2 = Trip.trips_high("max_temp", 80, 89.9)
      expected_3 = Trip.trips_avg("max_temp", 80, 89.9)

      expect(expected_1).to eq(1.0)
      expect(expected_2).to eq(3.0)
      expect(expected_3).to eq(2.0)
    end
  end
end
