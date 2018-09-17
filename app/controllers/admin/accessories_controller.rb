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

  def new
    @accessory = Accessory.new()
  end

  def create
    accessory = Accessory.create(accessory_params)
    flash[:notice] = "Successfully created a new accessory!"
    redirect_to accessory_path(accessory)
  end

  def index
    if current_user && current_user.admin?
      @accessories = Accessory.all
    else
      render file:'public/404'
    end
  end

  private
    def accessory_params
      params.require(:accessory).permit(:image, :title, :description, :price, :slug, :retired)
    end

end
