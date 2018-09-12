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
    @most_rides = trips.most_rides
  end

end
