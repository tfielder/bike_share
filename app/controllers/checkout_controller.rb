class CheckoutController < ApplicationController
  include ActionView::Helpers::TextHelper
  def create
    current_user.orders.create(status: "pending")

    if current_user.orders
      total = '%.2f' % @cart.cart_total
      num_items = @cart.accessories.count
      session[:cart] = nil
      flash[:notice] = "Successfully submitted your order totaling $#{total}! You ordered #{@cart.accessories.count} items."
      redirect_to dashboard_path
    else
      flash[:notice] = "Something went wrong, try again later."
      redirect_to bike_shop_path
    end
  end
end