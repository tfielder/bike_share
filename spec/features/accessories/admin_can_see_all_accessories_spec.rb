require 'rails_helper'

describe 'as an admin' do
  describe 'when visiting link for viewing all accessories' do
    before(:each) do
      @item_1 = Accessory.create(title: "happy1", image: "image1", description: "sogood1", price: 10.01, retired: false)
      @item_2 = Accessory.create(title: "happy2", image: "image2", description: "sogood2", price: 10.02, retired: true)
      @item_3 = Accessory.create(title: "happy3", image: "image3", description: "sogood3", price: 10.03, retired: false)

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

      expect(current_path).to eq('/admin/bike-shop')
      expect(current_path).to eq(admin_bike_shop_path)

    end
    it 'shows a table with all accessories' do
      visit admin_bike_shop_path

      expect(page).to have_content("#{@item_1.title}")
      expect(page).to have_content("#{@item_1.description}")
      expect(page).to have_content("#{@item_1.price}")
      expect(page).to have_css("img[src*='#{@item_1.image}']")
      expect(page).to have_content("#{@item_2.title}")
      expect(page).to have_content("#{@item_2.description}")
      expect(page).to have_content("#{@item_2.price}")
      expect(page).to have_css("img[src*='#{@item_2.image}']")
      expect(page).to have_content("#{@item_3.title}")
      expect(page).to have_content("#{@item_3.description}")
      expect(page).to have_content("#{@item_3.price}")
      expect(page).to have_css("img[src*='#{@item_3.image}']")

      expect(page).to have_content("Retire")
      expect(page).to have_content("Reactivate")
      expect(page).to have_content("Edit")
    end
    it 'allows admin to edit an accessory' do
      visit admin_bike_shop_path

      expect(page).to have_content("#{@item_1.title}")
      expect(page).to have_content("#{@item_1.description}")
      expect(page).to have_content("#{@item_1.price}")
      expect(page).to have_css("img[src*='#{@item_1.image}']")
      expect(page).to have_content("#{@item_2.title}")
      expect(page).to have_content("#{@item_2.description}")
      expect(page).to have_content("#{@item_2.price}")
      expect(page).to have_css("img[src*='#{@item_2.image}']")

      first('.edit').click

      expect(current_path).to eq(edit_admin_accessory_path(@item_1))
    end
    it 'allows an admin to retire an accessory' do
      visit admin_bike_shop_path

      expect(@item_1.retired).to eq(false)

      first('.toggle').click
      @item_1.reload
      expect(@item_1.retired).to eq(true)
    end
  end
end