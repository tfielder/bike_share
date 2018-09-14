class Admin::TripsController < Admin::BaseController
before_action :set_trip, only: [:destroy, :edit, :update]

  def destroy
    @trip.destroy
    flash[:notice] = "Successfully deleted."
    redirect_to trips_path
  end

  def edit
    @admin = current_user.role
    @station = Station.find_by(params[@trip[:start_station_id]])
  end

  def update
    @trip.update(trip_params)
    flash[:notice] = "Successfully updated!"
    redirect_to trip_path(@trip)
  end

  def new
    @trip = Trip.new()
  end

  private
  def trip_params
    params.require(:trip).permit(:duration, :start_station_id, :start_date, :end_station_id, :end_station, :end_date, :bike_id, :subscription_type, :zip_code)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end
end
