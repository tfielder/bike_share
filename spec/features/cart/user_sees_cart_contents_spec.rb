require 'rails_helper'

describe 'As a registered user' do
  describe 'when visiting /cart' do
    before(:each) do
      user = User.create(name: "Beemo", email: "bmo@email.com", password: "pass", password_confirmation: "pass")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      @item_1 = Accessory.create(title: "happy1", image: "image1", description: "sogood1", price: 10.01)
      @item_2 = Accessory.create(title: "happy2", image: "image2", description: "sogood2", price: 10.02)
      @item_3 = Accessory.create(title: "happy3", image: "image3", description: "sogood3", price: 10.03)

      

      visit cart_path
    end
    it 'shows small image, title, and price for each accessory in the cart' do

    end
    it 'shows a subtotal, quantity breakdown for each accessory and total for cart' do

    end
    it 'shows a button to checkout' do

    end
  end
end