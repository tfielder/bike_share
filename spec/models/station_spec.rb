require 'rails_helper'

describe Station, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :dock_count}
    it {should validate_presence_of :city}
    it {should validate_presence_of :installation_date}
  end
  describe 'methods' do
    before(:each) do
      user = User.create(name: "Beemo", email: "bmo@email.com", password: "pass", password_confirmation: "pass")
      user.addresses.create(address: "The Moon")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      @station_1 = Station.create(name:"1 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      @station_2 = Station.create(name:"2 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
      @station_3 = Station.create(name:"3 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))

      @trip_1 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:@station_1, end_date: ("09/01/2018"), end_station:@station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      @trip_2 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:@station_1, end_date: ("09/01/2018"), end_station:@station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
      @trip_3 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:@station_2, end_date: ("09/01/2018"), end_station:@station_3,bike_id: 3, subscription_type:"Subsciber", zip_code: 94128 )
      @trip_4 = Trip.create(duration: 2, start_date: ("09/03/2018"), start_station:@station_2, end_date: ("09/01/2018"), end_station:@station_3,bike_id: 3, subscription_type:"Subsciber", zip_code: 94128 )
    end
    it "#rides_started" do
      expect(@station_2.rides_started).to eq(2)
    end
    it "#rides_ended" do
      expect(@station_2.rides_ended).to eq(2)
    end
    it "#frequent_destination" do
      expect(@station_2.frequent_destination).to eq(@station_3.name)
    end
    it "#frequent_origination" do
      expect(@station_2.frequent_origination).to eq(@station_1.name)
    end
    it "#most_trips" do
      expect(@station_2.most_trips).to eq(@trip_1.start_date)
    end
    it "#frequent_zip" do
      expect(@station_2.frequent_zip).to eq(94128)
    end
    it "#frequent_bike_id" do
      expect(@station_2.frequent_bike_id).to eq(3)
    end
  end
end
