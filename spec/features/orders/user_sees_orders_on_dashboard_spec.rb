require 'rails_helper'

describe 'as a user' do
  describe "when I visit my dashboard" do
    it "should show me my orders" do
      accessory1 = Accessory.create!( image: "holder.jpg",
                                    title: "Bones",
                                    description: "Some bones",
                                    price: 13.35
                                  )
      accessory2 = Accessory.create!( image: "holder.jpg",
                                    title: "Bonesin",
                                    description: "Some bones",
                                    price: 13.35,
                                    retired: true
                                  )
      user = User.create!(name: "Finn", email: "pip@pip.com", password_digest: "123")
      order = user.orders.create!(items: {accessory1.id => 2, accessory2.id => 1}, user_id: user.id)

      visit login_path

      fill_in "Email", with: "pip@pip.com"
      fill_in "Password", with: "123"

      click_on "#{order.id}"

      expect(current_path).to eq(order_path(order))
    end
  end
end
