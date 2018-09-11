class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    if current_user.orders.include?(@order)
      @accessories = @order.accessory_count
      @total_price = @order.total_price
    else
      redirect_to dashboard_path
      flash[:notice] = "You are not authorized to view this page."
    end
  end

end
