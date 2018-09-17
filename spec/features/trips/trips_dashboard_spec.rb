require 'rails_helper'

describe'a registered user can visits trips dashboard' do
  it 'displays the average duration of the ride' do
    @user1 = User.create(name: "Beemo", email: "bmo@email.com", password: "pass", password_confirmation: "pass")
    @user2 = User.create(name: "Zebra", email: "zebra@email.com", password: "test", password_confirmation: "test")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)


    station_1 = Station.create(name:"1 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))
    station_2 = Station.create(name:"2 station",dock_count: 3, city: "Denver", installation_date: Date.strptime("03/23/2016", '%m/%d/%Y'))

    trip_1 = Trip.create!(duration: 42, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subscriber", zip_code: 94127 )
    trip_2 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Subscriber", zip_code: 94127 )
    trip_3 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 4, subscription_type:"Customer", zip_code: 94127 )
    trip_4 = Trip.create(duration: 2, start_date: ("09/01/2018"), start_station:station_1, end_date: ("09/01/2018"), end_station:station_2,bike_id: 2, subscription_type:"Customer", zip_code: 94127 )

    condition = Condition.create(date:"09/01/2018", max_temp:81.0, mean_temp:76.0, min_temp:41.0, mean_humidity:13.0, mean_visibility:12.0, mean_wind_speed:5.0, precip:0.0)
    condition_no = Condition.create(date:"09/02/2018", max_temp:81.0, mean_temp:76.0, min_temp:41.0, mean_humidity:13.0, mean_visibility:12.0, mean_wind_speed:5.0, precip:0.0)

    trips = Trip.all
    @average = trips.average_duration
    @longest = trips.longest_ride
    @shortest = trips.shortest_ride
    @most_rides_start_count = trips.most_rides_start.count
    @most_rides_start_name= trips.most_rides_start.name
    @most_rides_end_count = trips.most_rides_end.count
    @most_rides_end_name = trips.most_rides_end.name
    @most_bike_rides_id= trips.most_bike_rides.bike_id
    @most_bike_rides_count = trips.most_bike_rides.count
    @least_bike_rides_id = trips.least_bike_rides.bike_id
    @least_bike_rides_count = trips.least_bike_rides.count
    @date_with_most_trips_day = trips.date_with_most_trips.start_date
    @date_with_most_trips_count = trips.date_with_most_trips.count
    @date_with_least_trips_day = trips.date_with_least_trips.start_date
    @date_with_least_trips_count = trips.date_with_least_trips.count
    @user_subscription_breakdown_count_subscriber = trips.user_subscription_breakdown["Subscriber"]
    @user_subscription_breakdown_count_customer = trips.user_subscription_breakdown["Customer"]
    @subscriber_percentage = (trips.user_subscription_breakdown["Subscriber"].to_f/Trip.count* 100).round(2)
    @customer_percentage = (trips.user_subscription_breakdown["Customer"].to_f/Trip.count * 100).round(2)
    @weather_on_most_trips = Condition.condition_on_date(@date_with_most_trips_day).first
    @weather_on_least_trips = Condition.condition_on_date(@date_with_least_trips_day).first
    @monthly_breakdown = trips.monthly_breakdown

    visit trips_dashboard_path
    save_and_open_page
    expect(page).to have_content("Average Duration: #{@average} seconds")
    expect(page).to have_content("Longest Ride: #{@longest} seconds")
    expect(page).to have_content("Shortest Ride: #{@shortest} seconds")
    expect(page).to have_content("Start Station with most trips: #{@most_rides_start_count} trips at #{@most_rides_start_name}")
    expect(page).to have_content("End Station with most trips: #{@most_rides_end_count} trips at #{@most_rides_end_name}")
    expect(page).to have_content("Bike with the most rides: Bike #{@most_bike_rides_id} had #{@most_bike_rides_count} rides")
    expect(page).to have_content("Bike with the least rides: Bike #{@least_bike_rides_id} had #{@least_bike_rides_count} rides")
    expect(page).to have_content("Date with the most amount of trips: #{@date_with_most_trips_count}, on #{@date_with_most_trips_day.strftime("%m/%d/%Y")}")
    expect(page).to have_content("Weather for #{@date_with_most_trips_day.strftime("%m/%d/%Y")}:")
    expect(page).to have_content("Max Temp: #{@weather_on_most_trips.max_temp}")
    expect(page).to have_content("Mean Temp: #{@weather_on_most_trips.mean_temp}")
    expect(page).to have_content("Min Temp: #{@weather_on_most_trips.min_temp}")
    expect(page).to have_content("Mean Humidity: #{@weather_on_most_trips.mean_humidity}")
    expect(page).to have_content("Mean Visibility: #{@weather_on_most_trips.mean_visibility}")
    expect(page).to have_content("Mean Wind Speed: #{@weather_on_most_trips.mean_wind_speed}")
    expect(page).to have_content("Mean Precipitation: #{@weather_on_most_trips.precip}")
    expect(page).to have_content("Date with the least amount of trips: #{@date_with_least_trips_count}, on #{@date_with_least_trips_day.strftime("%m/%d/%Y")}")
    expect(page).to have_content("Weather for #{@date_with_least_trips_day.strftime("%m/%d/%Y")}:")
    expect(page).to have_content("Max Temp: #{@weather_on_least_trips.max_temp}")
    expect(page).to have_content("Mean Temp: #{@weather_on_least_trips.mean_temp}")
    expect(page).to have_content("Min Temp: #{@weather_on_least_trips.min_temp}")
    expect(page).to have_content("Mean Humidity: #{@weather_on_least_trips.mean_humidity}")
    expect(page).to have_content("Mean Visibility: #{@weather_on_least_trips.mean_visibility}")
    expect(page).to have_content("Mean Wind Speed: #{@weather_on_least_trips.mean_wind_speed}")
    expect(page).to have_content("Mean Precipitation: #{@weather_on_least_trips.precip}")
    expect(page).to have_content("Subscriber breakdown: #{@user_subscription_breakdown_count_subscriber} subscribers and #{@user_subscription_breakdown_count_customer} customers. #{@subscriber_percentage}% subscribers and #{@customer_percentage}% customers.")
    expect(page).to have_content("Monthly Breakdown: 01/01/2018 4")

  end
end
