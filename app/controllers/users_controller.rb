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
    @user = current_user
    @orders = @user.orders
    checkout = Checkout.new(@user)
    cart.accessories.each do |accessory, number|
      checkout.accessories.new(accessory: accessory_id, quantity: number)
    end

    if checkout.save
      total = @cart.sub_total
      num_items = @cart.accessories.count
      session[:cart] = nil
      flash[:notice] = "Successfully submitted your order totaling $#{total}! You ordered #{num_items} items."
      redirect_to dashboard_path

    else
      flash[:notice] = "Something went wrong, try again later."
      redirect_to bike_shop_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
