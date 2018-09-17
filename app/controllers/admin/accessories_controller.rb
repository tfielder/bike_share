class Admin::AccessoriesController < Admin::BaseController

  def edit
    if current_user && current_user.admin?
      @accessory = Accessory.find_by(slug: params[:slug])
      @admin = current_user
    else
      render file:'public/404'
    end
  end

  def update
    @accessory = Accessory.find_by(slug: params[:slug])
    @accessory.update(accessory_params)
    flash[:notice] = "Successfully updated!"
    redirect_to admin_bike_shop_path
  end

  def update_accessory
    @accessory = Accessory.find_by(slug: params[:slug])
    @admin = current_user
    if @accessory.retired
      @accessory.update_attributes!(retired: false)
    else
      @accessory.update_attributes!(retired: true)
    end
    redirect_to admin_bike_shop_path
  end

  private
    def accessory_params
      params.require(:accessory).permit(:image, :title, :description, :price, :retired)
    end

end