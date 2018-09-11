class CheckoutController < ApplicationController
  include ActionView::Helpers::TextHelper
  def create
    checkout = Checkout.new(@current_user)
    cart.accessories.each do |accessory, number|
      checkout.accessories.new(accessory: accessory_id, quantity: number)
    end

    if checkout.save
      session[:cart] = nil
      flash[:notice] = "Your order is checked out! You ordered #{checkout.accessories.count} items."
      redirect_to bike_shop_path
    else
      flash[:notice] = "Something went wrong, try again later."
    end
  end
end