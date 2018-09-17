require 'rails_helper'

feature 'Admin creates accessory' do
  context 'as an admin' do

    before do
      admin = User.create!(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_bike_shop_path
    end

    context 'when I click on Create Accessory' do
      scenario 'it takes me to a new accessory form' do
        click_on "Create Accessory"

        expect(current_path).to eq(new_admin_accessory_path)
        expect(page).to have_content("Create a new accessory:")
        expect(page).to have_content("Title:")
        expect(page).to have_content("Image:")
        expect(page).to have_content("Description:")
        expect(page).to have_content("Price:")
      end
      context 'when I fill in the form and click submit' do
        scenario 'it creates a accessory' do
          click_on "Create Accessory"

          fill_in :title, with: "Lights Out"
          fill_in :Description, with: "If you weren't afraid of the dark, you are now."
          fill_in :price, with: 172.0

          click_on "Submit"

          accessory = Accessory.last

          expect(current_path).to eq(accessory_path(accessory))
          expect(page).to have_content("Successfully created a new accessory!")
          expect(page).to have_content("Title: #{accessory.title}")
          expect(page).to have_content("Description: #{accessory.description}")
          expect(page).to have_content("Price: #{accessory.price}")
        end
      end
    end
  end
  context 'as default user' do
    before do
      user = User.create!(name: "Dalek", email: "dalek@email.com", password: "hack", password_confirmation: "hack", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit new_admin_accessory_path
    end
    scenario 'I cannot see the new accessory page' do
      expect(page).to_not have_content("Create a new accessory:")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
  context 'as visitor' do
    before do
      visit new_admin_accessory_path
    end
    scenario 'I cannot see the edit accessory page' do
      expect(page).to_not have_content("Create a new accessory:")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
