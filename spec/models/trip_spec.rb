require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:duration)}
    it {should validate_presence_of(:start_date)}
    it {should validate_presence_of(:end_date)}
    it {should validate_presence_of(:bike_id)}
    it {should validate_presence_of(:subscription_type)}
    it {should validate_presence_of(:zip_code)}
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
  end
end
