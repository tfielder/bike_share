class AccessoriesController < ApplicationController

  def show
    @accessory = Accessory.find_by(slug: params[:slug])
  end

  def index
    if current_user && current_user.admin?
      @accessories = Accessory.all
    else
      render file:'public/404'
    end
  end

  def edit
    if current_user && current_user.admin?
      @accessory = Accessory.find_by(accessory_params)
    else
      render file:'public/404'
    end
  end

  def update
    @accessory.update(accessory_params)
    flash[:notice] = "Successfully updated!"
    redirect_to admin_bike_shop_path
  end

  private
    def accessory_params
      params.require(:accessory).permit(:)
    end

end
