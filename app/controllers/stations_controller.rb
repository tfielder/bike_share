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
    @most_bikes = stations.maximum(:dock_count)
    @station_most_bikes = stations.order(dock_count: :DESC).first.name
    @least_bikes = stations.minimum(:dock_count)
    @station_least_bikes = stations.order(dock_count: :ASC).first.name
    @newest_station = stations.order(installation_date: :DESC).first.name
    @oldest_station = stations.order(installation_date: :DESC).last.name
  end

end
