class Admin::StationsController < Admin::BaseController

  def index
    @stations = Station.all
  end

  def show
    @station = Station.find_by(slug: params[:slug])
  end

  def edit
    @station = Station.find_by(slug: params[:slug])
    @admin = current_user.role
  end

  def update
    station = Station.find_by(slug:params[:slug])
    station.update(station_params)
    flash[:notice] = "Successfully updated!"
    redirect_to admin_station_path(station)
  end

  def destroy
    station = Station.find_by(slug:params[:slug])
    station.destroy
    redirect_to admin_stations_path, notice: "Successfully deleted."
  end

  private
  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date)
  end
end
