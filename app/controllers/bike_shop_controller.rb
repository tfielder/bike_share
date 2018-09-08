class BikeShopController < ApplicationController
  def index
    @accessories = Accessory.all
  end
end