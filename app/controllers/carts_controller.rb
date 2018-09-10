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
    @accessory = Accessory.find(params[:accessory_id])
    @accesories.remove_accessory(@accessory.id.to_s)
    flash[:notice] = "Successfully removed #{@accessory.title} from your cart."
    redirect_to '/cart'
  end
end
