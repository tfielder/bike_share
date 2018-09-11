class Admin::StationsController < Admin::BaseController
  def index
    @stations = Station.all
  end

  def show
    @station = Station.find(slug: params[:slug])
  end
end
