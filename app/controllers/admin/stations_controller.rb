class Admin::StationsController < Admin::BaseController

  def index
    @stations = Station.all
  end

  def show
    @station = Station.find_by(slug: params[:slug])
  end

  def edit
    @station = Station.find_by(slug: params[:slug])
  end
end
