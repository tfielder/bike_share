class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  def create
    accessory = Accessory.find(params[:item_id])
    @cart= Cart.new(session[:cart])
    @cart.add_accessory(accessory.id)
    session[:cart] = @cart.contents

    flash[:notice] = "#{accessory.title} was added to the cart."
    redirect_to bike_shop_path
  end

  def show

  end
end
