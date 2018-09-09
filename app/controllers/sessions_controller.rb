class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to dashboard_path, notice: "Welcome back!"
    else
      flash.now.alert = "Incorrect email or password, please try again."
      render :new
    end 
  end
end
