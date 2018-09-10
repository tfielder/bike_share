class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    @user.email.downcase!

    if @user.save
      flash[:notice] = "Wecome to Bike Share #{@user.name}"
      session[:user_id] = @user.id

      redirect_to :dashboard
    else
      flash.now.alert "Please try again."
      render :new
    end 
  end

  def dashboard

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end