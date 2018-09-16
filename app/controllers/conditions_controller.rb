class ConditionsController < ApplicationController
  def index
    @conditions = Condition.all
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def dashboard
    if current_user
      # sql_max_40 = "SELECT COUNT(start_date) FROM trips JOIN conditions ON conditions.date = trips.start_date WHERE max_temp BETWEEN 40.0 AND 49.9 GROUP BY start_date ORDER BY count desc LIMIT 1"
      @max_40 = Trip.max_temp_data("max_temp", 40.0, 49.9)
      @max_50 = Trip.max_temp_data("max_temp", 50.0, 59.9 )
      @max_60 = Trip.max_temp_data("max_temp", 60.0, 69.9 )
      @max_70 = Trip.max_temp_data("max_temp", 70.0, 79.9 )
      @max_80 = Trip.max_temp_data("max_temp", 80.0, 89.9 )
      @max_90 = Trip.max_temp_data("max_temp", 90.0, 99.9 )

      @precip0_5 = Trip.precip_data("precip", 0.0,0.4)
      @precip5_1 = Trip.precip_data("precip", 0.5,0.9)
      @precip_1_5 = Trip.precip_data("precip", 1.0,1.4)
      @precip_5_2 = Trip.precip_data("precip", 1.5,1.9)
      @precip_2_5 = Trip.precip_data("precip", 2.0,2.4)
      @precip_5_3 = Trip.precip_data("precip", 2.5,2.9)
      @precip_3_5 = Trip.precip_data("precip", 3.0,3.5)

      @wind_3 = Trip.wind_data("mean_wind_speed", 0,3)
      @wind_7 = Trip.wind_data("mean_wind_speed", 4,7)
      @wind_11 = Trip.wind_data("mean_wind_speed", 8,11)
      @wind_15 = Trip.wind_data("mean_wind_speed", 12,15)
      @wind_19 = Trip.wind_data("mean_wind_speed", 16,19)

      @vis_3 = Trip.vis_data("mean_visibility", 0,3)
      @vis_7 = Trip.vis_data("mean_visibility", 4,7)
      @vis_11 = Trip.vis_data("mean_visibility", 8,11)
      @vis_15 = Trip.vis_data("mean_visibility", 12,15)
      @vis_19 = Trip.vis_data("mean_visibility", 16,19)
    else
      render file: 'public/404'
    end
  end

end
