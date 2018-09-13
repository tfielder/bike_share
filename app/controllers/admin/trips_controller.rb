class Admin::TripsController < Admin::BaseController
  def index
    @trips = Trip.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    flash[:notice] = "Successfully deleted."
    redirect_to admin_trips_path
  end

  def edit
    @trip = Trip.find(params[:id])
    @station = Station.find_by(params[@trip[:start_station_id]])
  end
end
