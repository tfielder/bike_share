require 'rails_helper'

describe "as a registered user" do
  describe "when I visit a station show page" do
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

      visit station_path(@station_2)
    end
    it "should show number of rides started at station" do
      expected = @station_2.rides_started

      expect(page).to have_content("Rides Started Here: #{expected}")
    end
    it "should show number of rides ended at this stations" do
      expected = @station_2.rides_ended

      expect(page).to have_content("Rides Ended Here: #{expected}")
    end
    it "should show most frequent destination station for rides that begin at this stations" do
      expected = @station_2.frequent_destination

      expect(page).to have_content("Most Frequent Destination: #{expected}")
    end
    it "should show most frequent origination station for rides that end at this stations" do
      expected = @station_2.frequent_origination

      expect(page).to have_content("Most Frequent Origin: #{expected}")
    end
    it "should show the date with the highest number of trips started at this station" do
      expected = @station_2.most_trips

      expect(page).to have_content("Date With Most Trips: #{expected}")
    end
    it "should show most frequent zip code for users starting trips at this station" do
      expected = @station_2.frequent_zip

      expect(page).to have_content("Most Frequent User Zip Code: #{expected}")
    end
    it "should show the bike id most frequently starting trips at this station" do
      expected = @station_2.frequent_bike_id

      expect(page).to have_content("Most Frequently Used Bike ID: #{expected}")
    end
  end
end
