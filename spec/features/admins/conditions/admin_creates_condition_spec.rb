require 'rails_helper'

feature 'Admin creates condition' do
  context 'as an admin' do

    before do
      admin = User.create!(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit conditions_path
    end

    context 'when I click on Create Condition' do
      scenario 'it takes me to a new condition form' do
        click_on "Create Condition"

        expect(current_path).to eq(new_admin_condition_path)
        expect(page).to have_content("Create a new condition:")
        expect(page).to have_content("Date:")
        expect(page).to have_content("Max temp:")
        expect(page).to have_content("Mean temp:")
        expect(page).to have_content("Min temp:")
        expect(page).to have_content("Mean humidity:")
        expect(page).to have_content("Mean visibility:")
        expect(page).to have_content("Mean wind speed:")
        expect(page).to have_content("Precip:")
      end
      context 'when I fill in the form and click submit' do
        xscenario 'it creates a condition' do
          click_on "Create Condition"

          fill_in("Date", :with => "10/1/2013")
          fill_in :condition_max_temp, with: 70.0
          fill_in :condition_mean_temp, with: 65.0
          fill_in :condition_min_temp, with: 55.0
          fill_in :condition_mean_humidity, with: 20.0
          fill_in :condition_mean_visibility, with: 100.0
          fill_in :condition_mean_wind_speed, with: 2.0
          fill_in :condition_precip, with: 5.0

          click_on "Submit"

          condition = Condition.last

          expect(current_path).to eq(condition_path(condition))
          expect(page).to have_content("Successfully created a new condition!")
          expect(page).to have_content("Date: #{condition.date.strftime("%m/%d/%Y")}")
          expect(page).to have_content("Max Temperature: #{condition.max_temp}")
          expect(page).to have_content("Mean Temperature: #{condition.mean_temp}")
          expect(page).to have_content("Min Temperature: #{condition.min_temp}")
          expect(page).to have_content("Mean Humidity: #{condition.mean_humidity}")
          expect(page).to have_content("Mean Visibility: #{condition.mean_visibility}")
          expect(page).to have_content("Mean Wind Speed: #{condition.mean_wind_speed}")
          expect(page).to have_content("Precipitation: #{condition.precip}")
        end
      end
    end
  end
  context 'as default user' do
    before do
      user = User.create!(name: "Dalek", email: "dalek@email.com", password: "hack", password_confirmation: "hack", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit new_admin_condition_path
    end
    scenario 'I cannot see the new condition page' do
      expect(page).to_not have_content("Create a new condition:")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
  context 'as visitor' do
    before do
      visit new_admin_condition_path
    end
    scenario 'I cannot see the edit condition page' do
      expect(page).to_not have_content("Create a new condition:")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
