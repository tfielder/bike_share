require 'rails_helper'
describe 'trip show page' do
  it 'should display all details for an individual trip' do
    station_1 = Station.create(name:"1 station",dock_count: 3, city: "Denver", installation_date:"03/23/2016")
    station_2 = Station.create(name:"2 station",dock_count: 3, city: "Denver", installation_date:"03/23/2016")
    trip_1 = Trip.create(duration: 42, start_date:"09/01/2018", start_station:station_1, end_date:"09/01/2018", end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )

    visit trip_path(trip_1)
    save_and_open_page
    expect(page).to have_content(trip_1.duration)
    expect(page).to have_content(trip_1.start_date)
    expect(page).to have_content(trip_1.start_station.name)
    expect(page).to have_content(trip_1.end_date)
    expect(page).to have_content(trip_1.end_station.name)
    expect(page).to have_content(trip_1.bike_id)
    expect(page).to have_content(trip_1.subscription_type)
    expect(page).to have_content(trip_1.zip_code)
  end
end
