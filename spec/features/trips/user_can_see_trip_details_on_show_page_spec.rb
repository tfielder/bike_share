require 'rails_helper'
describe 'trip show page' do
  it 'should display all details for an individual trip' do
    station_1 = Station.create(name:"start station",dock_count: 3, city: "Denver", installation_date: Date.strptime('03/23/2016','%m/%d/%Y'))
    station_2 = Station.create(name:"end station",dock_count: 3, city: "Denver", installation_date:Date.strptime("03/23/2016",'%m/%d/%Y'))
    trip_1 = Trip.create(duration: 42, start_date:Date.strptime("09/01/2018",'%m/%d/%Y'), start_station:station_1, end_date:Date.strptime("09/01/2018",'%m/%d/%Y'), end_station:station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )

    visit trips_path

    click_on trip_1.id

    expect(current_path).to eq(trip_path(trip_1))


    expect(page).to have_content(trip_1.duration)
    expect(page).to have_content(trip_1.start_date.strftime("%m/%d/%Y"))
    expect(page).to have_content(trip_1.start_station.name)
    expect(page).to have_content(trip_1.end_date.strftime("%m/%d/%Y"))
    expect(page).to have_content(trip_1.end_station.name)
    expect(page).to have_content(trip_1.bike_id)
    expect(page).to have_content(trip_1.subscription_type)
    expect(page).to have_content(trip_1.zip_code)
  end
end
