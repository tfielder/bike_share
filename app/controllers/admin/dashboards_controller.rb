class Admin::DashboardsController < ApplicationController

  def show
    @user = current_user
    @orders = @user.orders
    @all_orders = Order.all
  end

end
