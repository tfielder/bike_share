class Admin::ConditionsController < Admin::BaseController
  before_action :set_condition, only: [:destroy, :edit]

  def destroy
    @condition.destroy
    redirect_to conditions_path, notice: "Successfully deleted."
  end

  def new
    @condition = Condition.new()
    @admin = current_user.role
  end

  def create
    condition = Condition.create(condition_params)
    flash[:notice] = "Successfully created a new condition!"
    redirect_to condition_path(condition)
  end

  def edit
    @admin = current_user.role
  end

  private
    def set_condition
      @condition = Condition.find(params[:id])
    end

    def condition_params
      params.require(:condition).permit(:max_temp, :mean_temp, :min_temp, :mean_humidity, :mean_visibility, :mean_wind_speed, :precip)
    end
end
