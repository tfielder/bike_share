require 'rails_helper'

describe 'As a registered user' do
  describe 'when visiting /cart' do
    before(:each) do
      user = User.create(name: "Beemo", email: "bmo@email.com", password: "pass", password_confirmation: "pass")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      @item_1 = Accessory.create(title: "happy1", image: "image1", description: "sogood1", price: 10.01)
      @item_2 = Accessory.create(title: "happy2", image: "image2", description: "sogood2", price: 10.02)
      @item_3 = Accessory.create(title: "happy3", image: "image3", description: "sogood3", price: 10.03)

      visit bike_shop_path

      first(".bike_shop_item_#{@item_2.id}").click_on("Add to Cart")
      first(".bike_shop_item_#{@item_2.id}").click_on("Add to Cart")
      first(".bike_shop_item_#{@item_3.id}").click_on("Add to Cart")

      visit cart_path
    end
    it 'shows small image, title, price, quantity breakdown and total for each accessory in the cart' do

      expect(page).to have_css("img[src*='image2']")
      expect(page).to have_content("#{@item_2.title} $#{@item_2.price} Qty: 2 Subtotal: $20.04")
      expect(page).to have_css("img[src*='image3']")
      expect(page).to have_content("#{@item_3.title} $#{@item_3.price} Qty: 1 Subtotal: $10.03")

    end
    it 'shows subtotal for cart' do
      expect(page).to have_content("Cart Total: $30.07")
    end

    it 'shows a button to checkout' do
      expect(page).to have_selector(:link_or_button, 'Checkout')
    end

  end
end
