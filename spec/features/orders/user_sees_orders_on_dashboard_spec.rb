require 'rails_helper'

describe 'as a user' do
  describe "when I visit my dashboard" do
    it "should show me my orders" do
      user = User.create!(name: "Finn", email: "pip@pip.com", password: "123")
      order = user.orders.create!(status: "completed")
      accessory1 = order.accessories.create!( image: "holder.jpg",
                                 title: "Bonesin",
                                 description: "Some bones",
                                 price: 13.35
                                )
      accessory2 = order.accessories.create!( image: "holder.jpg",
                                 title: "Bones",
                                 description: "Some bones",
                                 price: 13.35
                                )
      order.accessories << accessory2

      visit login_path

      fill_in "Email", with: "pip@pip.com"
      fill_in "Password", with: "123"
      click_on "Submit"
      click_on "#{order.id}"

      expect(current_path).to eq(order_path(order))
      expect(page).to have_content(order.status)
      expect(page).to have_content(order.total_price)
      expect(page).to have_content(order.updated_at)
      expect(page).to have_content(order.created_at)
      save_and_open_page
    end
  end
end
