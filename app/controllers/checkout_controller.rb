class CheckoutController < ApplicationController
  include ActionView::Helpers::TextHelper
  def create
    binding.pry
    checkout = Checkout.new(@current_user)
    cart.accessories.each do |accessory, number|
      checkout.accessories.new(accessory: accessory_id, quantity: number)
    end

    if checkout.save
      total = @cart.sub_total
      num_items = @cart.accessories.count
      session[:cart] = nil
      flash[:notice] = "Successfully submitted your order totaling $#{total}! You ordered #{num_items} items."
      redirect_to dashboard_path

    else
      flash[:notice] = "Something went wrong, try again later."
      redirect_to bike_shop_path
    end
  end
end