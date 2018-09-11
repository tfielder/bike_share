class CheckoutController < ApplicationController
  include ActionView::Helpers::TextHelper
  def create
    checkout = Checkout.new(@current_user)
    cart.accessories.each do |accessory, number|
      checkout.accessories.new(accessory: accessory_id, quantity: number)
    end

    if checkout.save
      flash[:notice] = "Successfully submitted your order totaling $#{@cart.sub_total}! You ordered #{@cart.accessories.count} items."
      session[:cart] = nil
      redirect_to dashboard_path
    else
      flash[:notice] = "Something went wrong, try again later."
      redirect_to bike_shop_path
    end
  end
end