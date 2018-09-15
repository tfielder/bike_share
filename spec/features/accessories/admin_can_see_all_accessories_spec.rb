require 'rails_helper'

describe 'as an admin' do
  describe 'when visiting link for viewing all accessories' do
    before(:each) do
      @item_1 = Accessory.create(title: "happy1", image: "image1", description: "sogood1", price: 10.01)
      @item_2 = Accessory.create(title: "happy2", image: "image2", description: "sogood2", price: 10.02)
      @item_3 = Accessory.create(title: "happy3", image: "image3", description: "sogood3", price: 10.03)
      @item_4 = Accessory.create(title: "happy4", image: "image4", description: "sogood4", price: 10.04)
      @item_5 = Accessory.create(title: "happy5", image: "image5", description: "sogood5", price: 10.05)
      @item_6 = Accessory.create(title: "happy6", image: "image6", description: "sogood6", price: 10.06)
      @item_7 = Accessory.create(title: "happy7", image: "image7", description: "sogood7", price: 10.07)
      @item_8 = Accessory.create(title: "happy8", image: "image8", description: "sogood8", price: 10.08)
      @item_9 = Accessory.create(title: "happy9", image: "image9", description: "sogood9", price: 10.09)
      @item_10 = Accessory.create(title: "happy10", image: "image10", description: "sogood10", price: 10.10)
      @item_11 = Accessory.create(title: "happy11", image: "image11", description: "sogood11", price: 10.20)
      @item_12 = Accessory.create(title: "happy12", image: "image12", description: "sogood12", price: 10.30)

      @admin = User.create!(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end
    it 'shows link to view all accessories on admin dashboard' do
      visit admin_dashboard_path

      expect(page).to have_link("View All Accessories")
    end
    it 'brings the admin to the correct page' do
      visit admin_dashboard_path

      click_on "View All Accessories"

      expect(current_path).to eq('/admin/bike_shop')
      expect(current_path).to eq(admin_bike_shop_path)

    end
    it 'shows a table with all accessories' do
      visit admin_bike_shop_path

      expect(page).to have_content(@item_1.title)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.price)
      expect(page).to have_css("img[src*='#{@item_1.image}']")
      expect(page).to have_content(@item_2.title)
      expect(page).to have_content(@item_2.description)
      expect(page).to have_content(@item_2.price)
      expect(page).to have_css("img[src*='#{@item_2.image}']")
      expect(page).to have_content(@item_3.title)
      expect(page).to have_content(@item_3.description)
      expect(page).to have_content(@item_3.price)
      expect(page).to have_css("img[src*='#{@item_3.image}']")

      expect(page).to have_content("Retire/Reactivate")
      expect(page).to have_content("Edit")
    end
    it 'allows admin to edit an accessory' do

    end
    it 'allows an admin to retire an accessory' do

    end
  end
end