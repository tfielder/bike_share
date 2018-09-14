class Admin::DashboardsController < ApplicationController

  def show
    @user = current_user
    @orders = @user.orders
    if params[:status]
      @all_orders = Order.where(status: params[:status])
    else
      @all_orders = Order.all
    end
  end

end
