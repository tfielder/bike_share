class CartsController < ApplicationController
  def create
    accessory = Accessory.find(params[:item_id])
    flash[:notice] = "#{accessory.title} was added to the cart."
    redirect_to bike_shop_path
  end

  def show

  end
end
