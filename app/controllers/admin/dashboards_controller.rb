class Admin::DashboardsController < ApplicationController

  def show
    if current_user && current_user.admin?
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
    else
      render file: '/public/404'
    end
  end
end
