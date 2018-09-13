class StationsController < ApplicationController
  before_action :set_station, only: [:show]

  def index
    @stations = Station.all
  end

  def show

  end

  def dash
    stations = Station.all
    @count = stations.count
    @average = '%.2f' % stations.average(:dock_count)
    ordered_dock_count = stations.order(dock_count: :DESC)
    @most_bikes = ordered_dock_count.first.dock_count
    @least_bikes = ordered_dock_count.last.dock_count
    station_most_bikes_names = ordered_dock_count.where("dock_count = ?", "#{@most_bikes}")
    @station_most_bikes_names = station_most_bikes_names.map {|station| station.name}
    station_least_bikes_names = ordered_dock_count.where("dock_count = ?", "#{@least_bikes}")
    @station_least_bikes_names = station_least_bikes_names.map {|station| station.name}
    ordered_installation_date = stations.order(installation_date: :DESC)
    @newest_station = ordered_installation_date.first.name
    @oldest_station = ordered_installation_date.last.name
  end

  # def new
  #   @station = Station.new
  #   @admin = current_user.role
  # end
  #
  # def create
  #   station = Station.new(station_params)
  #   station.save
  #   flash[:notice] = "Successfully created #{station.name}!"
  #   redirect_to station_path(station)
  # end
  #
  # def edit
  #   @admin = current_user.role
  # end
  #
  # def update
  #   @station.update(station_params)
  #   flash[:notice] = "Successfully updated!"
  #   redirect_to station_path(@station)
  # end
  #
  # def destroy
  #   @station.destroy
  #   redirect_to stations_path, notice: "Successfully deleted."
  # end

  private
  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date)
  end

  def set_station

    @station = Station.find_by(slug: params[:slug])
  end

end
