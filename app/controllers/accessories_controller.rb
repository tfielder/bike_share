class AccessoriesController < ApplicationController

  def show
    @accessory = Accessory.find_by(slug: params[:slug])
  end

  

end
