require 'rails_helper'

describe'a registered user can visits trips dashboard' do
  it 'displays the average duration of the ride' do
    station_1 = Station.create(name:"1 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
    station_2 = Station.create(name:"2 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))

    trip_1 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
    trip_2 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
    trip_3 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
    trip_4 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )

    trips = Trip.all
    @average = trips.average_duration
    @longest = trips.longest_ride
    @shortest = trips.shortest_ride
    @most_rides = trips.most_rides

    visit trips_dashboard_path
    save_and_open_page
    expect(page).to have_content("Average Duration: #{@average}")
    expect(page).to have_content("Longest Ride: #{@longest}")
    expect(page).to have_content("Shortest Ride: #{@shortest}")
    expect(page).to have_content("Station with most trips: #{@most_rides.count} trips at #{@most_rides.name}")



  end
end
