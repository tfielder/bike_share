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

  private
  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date)
  end
end
