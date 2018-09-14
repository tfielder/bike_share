class Admin::DashboardsController < ApplicationController

  def show
    @user = current_user
    @orders = @user.orders
    if params[:status]
      @all_orders = Order.where(status: params[:status])
    else
      @all_orders = Order.all
    end
    @paid = Order.where(status: "paid")
    @ordered = Order.where(status: "ordered")
    @cancelled = Order.where(status: "cancelled")
    @completed = Order.where(status: "completed")
  end

end
