class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper
  def create
    accessory = Accessory.find(params[:item_id])
    @cart.add_accessory(accessory.id)
    session[:cart] = @cart.contents

    flash[:notice] = "#{accessory.title} was added to the cart."
    redirect_to bike_shop_path
  end

  def show
    @accessories = @cart.accessories
  end

  def destroy
     @cart.contents.delete(params[:item_id])
     @accessory = Accessory.find(params[:item_id])
     flash[:info] = "Successfully removed <a href=/bike-shop/#{@accessory.id}>'#{@accessory.title}'</a> from your cart."
    redirect_to cart_path
  end
end
