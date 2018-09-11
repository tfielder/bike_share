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
    accessory = Accessory.find(params[:item_id])
    # link = "<a href='/accessories/#{@accessory.title}'>#{@accessory.title}</a>".html_safe
    # flash[:notice] = "Successfully removed #{link} from your cart".html_safe
    flash[:remove] = "Successfully removed #{view_context.link_to accessory.title, accessory_path(accessory)} from your cart.".html_safe

    #flash[:notice] = "Successfully removed #{@accessory.title} from your cart."
    redirect_to cart_path
  end
end
