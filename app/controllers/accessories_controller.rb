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

end
