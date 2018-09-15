class Admin::ConditionsController < Admin::BaseController
  before_action :set_condition, only: [:destroy]
  
  def destroy
    @condition.destroy
    redirect_to conditions_path, notice: "Successfully deleted."
  end

  def set_condition
    @condition = Condition.find(params[:id])
  end
end
