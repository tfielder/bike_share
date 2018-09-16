class Admin::AccessoriesController < Admin::BaseController

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
      params.require(:accessory).permit(:image, :title, :description, :price, :slug, :retired)
    end

end