class StationsController < ApplicationController

  def index
    @stations = Station.all
  end

  def show
    @station = Station.find_by(slug: params[:slug])
  end

  def dash
    stations = Station.all
    @count = stations.count
    @average = stations.average(:dock_count)
    ordered_dock_count = stations.order(dock_count: :DESC)
    @most_bikes = ordered_dock_count.first.dock_count
    @least_bikes = ordered_dock_count.last.dock_count
    @station_most_bikes = ordered_dock_count.first.name
    @station_least_bikes = ordered_dock_count.last.name
    ordered_installation_date = stations.order(installation_date: :DESC)
    @newest_station = ordered_installation_date.first.name
    @oldest_station = ordered_installation_date.last.name

    #@most_bikes = stations.maximum(:dock_count)
    # @station_most_bikes = stations.order(dock_count: :DESC).first.name
    # @least_bikes = stations.minimum(:dock_count)
    # @station_least_bikes = stations.order(dock_count: :ASC).first.name
    # @newest_station = stations.order(installation_date: :DESC).first.name
    # @oldest_station = stations.order(installation_date: :DESC).last.name
  end

end
