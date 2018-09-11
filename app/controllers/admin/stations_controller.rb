class Admin::StationsController < ApplicationController
  before_action :require_admin

  def index
    @stations = Station.all
  end

  private
    def require_admin
      render file: "/public/404" unless current_admin?
    end 
end
