class TripsController < ApplicationController
  def index
    @trips = Trip.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def dashboard
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
  end

end
