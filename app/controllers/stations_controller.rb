class StationsController < ApplicationController

  def index
    @stations = Station.all
  end

  def show
    @station = Station.find_by(slug: params[:slug])
    binding.pry
    @rides_started_here = 1
    @rides_ended_here = 1
    @destination_station_from_here = 1
    @origination_station_ending_here = 1
    @most_trips_on_date = 1
    @most_frequent_zipcode = 1
    @most_famous_bike = 1
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

end
