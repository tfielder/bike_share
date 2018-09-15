class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    if current_admin? || (current_user && @order.user == current_user)
      @accessories = @order.accessory_count
      @user_details = @order.user.name
      @total_price = @order.total_price
    else
      render file: '/public/404'
    end
  end

  def update
    if current_admin?
      @order = Order.find(params[:id])
      @order.update(status: params[:status])
      if @order.save
        flash[:success] = "#{@order.id} updated!"
        redirect_to admin_dashboard_path
      else
        flash[:notice] = "#{@order.id} not updated!"
      end
    end
  end

  def destroy
    order = Order.find(params[:id])
    accessories = order.accessories
    accessories.each do |access|
      order_acc = OrderAccessory.where(order_id: order.id, accessory_id: access.id).first
      order_acc.destroy
    end
    order.destroy

    redirect_to admin_dashboard_path
    flash[:notice] = "Order #{params[:id]} was successfully deleted!"
  end

end
