require 'rails_helper'

describe 'trip index' do
  it 'displays the first 30 trips' do
    trip_1 = Trip.create(duration: 2, start_date:"09/01/2018", end_date:"09/01/2018", bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
    visit trips_path
    expect(page).to have_content()


  end
end
# As a visitor,
# When I visit the trips index,
# I see the first 30 trips (duration, start date, start station, end date, end station, bike id, subscription type, zip code),
# I also see a button to see more pages of trips,
#
# When I visit a second page, there should be buttons to move both forward and backward in time.
