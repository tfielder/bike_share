class ConditionsController < ApplicationController
  def index
    @conditions = Condition.all
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def dashboard
    # sql_max_40 = "SELECT COUNT(start_date) FROM trips JOIN conditions ON conditions.date = trips.start_date WHERE max_temp BETWEEN 40.0 AND 49.9 GROUP BY start_date ORDER BY count desc LIMIT 1"
    @max_40_avg = Trip.max_temp_avg(4)
    @max_40_high = Trip.max_temp_high(4)
    @max_40_low = Trip.max_temp_low(4)
    @max_50_avg = Trip.max_temp_avg(5)
    @max_50_high = Trip.max_temp_high(5)
    @max_50_low = Trip.max_temp_low(5)
    @max_60_avg = Trip.max_temp_avg(6)
    @max_60_high = Trip.max_temp_high(6)
    @max_60_low = Trip.max_temp_low(6)
    @max_70_avg = Trip.max_temp_avg(7)
    @max_70_high = Trip.max_temp_high(7) # = ActiveRecord::Base.connection.execute(sql_max_70)to_f
    @max_70_low = Trip.max_temp_low(7)
    @max_80_avg = Trip.max_temp_avg(8)
    @max_80_high = Trip.max_temp_high(8)
    @max_80_low = Trip.max_temp_low(8)
    @max_90_avg = Trip.max_temp_avg(9)
    @max_90_high = Trip.max_temp_high(9)
    @max_90_low = Trip.max_temp_low(9)
  end

end

Trip.select(Trip[:start_date].count).joins(
  Trip.join(:conditions).on(
    Condition[:date].eq(Trip[:start_date])
  ).join_sources
).order(:count).reverse_order.group(:start_date).limit(1)
