require 'rails_helper'

describe "as an admin" do
  describe 'on the edit accessory page' do
    before(:each) do
      @item_1 = Accessory.create(title: "happy1", image: "image1", description: "sogood1", price: 10.01, retired: false)
      @item_2 = Accessory.create(title: "happy2", image: "image2", description: "sogood2", price: 10.02, retired: true)
      @item_3 = Accessory.create(title: "happy3", image: "image3", description: "sogood3", price: 10.03, retired: false)

      @admin = User.create!(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end
    it 'allows an admin to edit an item' do
      visit edit_admin_accessory_path(@item_1)

      expect(page).to have_content("Image")
      expect(page).to have_content("Title")
      expect(page).to have_content("Description")
      expect(page).to have_content("Price")
    end
    it 'edits an item' do
      visit edit_admin_accessory_path(@item_1)

      fill_in "Image", with: "Cool"
      fill_in "Title", with: "Da boss"
      fill_in "Description", with: "The coolest"
      fill_in "Price", with: "10.99"
      click_on "Submit"

      expect(current_path).to eq(admin_bike_shop_path)
    end
    it "should render a 404 if user is not logged in or admin" do
      user = User.create!(name: "Dr.Who2", email: "thedoctor@tardis2.com", password: "blue", password_confirmation: "blue", role: 0)

      allow_any_instance_of(
        ApplicationController).to receive(
          :current_user).and_return(
            nil)
      visit edit_admin_accessory_path(@item_1)
      expect(page).to have_content("404")

      allow_any_instance_of(
        ApplicationController).to receive(
          :current_user).and_return(
            user)
      visit edit_admin_accessory_path(@item_1)
      expect(page).to have_content("404")
    end
  end
end
