require 'rails_helper'

feature 'Admin views admin conditions index page functions' do
  context 'As an admin' do
    context 'on the conditions index page' do

      let!(:condition_1){Condition.create(date:"09/01/2018", max_temp:80.0, mean_temp:75.0, min_temp:40.0, mean_humidity:12.5, mean_visibility:10.0, mean_wind_speed:10.0, precip:1.0)}
      let!(:condition_2){Condition.create(date:"09/02/2018", max_temp:81.0, mean_temp:76.0, min_temp:41.0, mean_humidity:13.0, mean_visibility:12.0, mean_wind_speed:5.0, precip:0.0)}

      before do
        admin = User.create!(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit conditions_path
      end

        scenario 'I am on the admin conditions index page' do
          expect(current_path).to eq(conditions_path)
          expect(page).to have_content("Admin Conditions")
        end

        scenario 'I view a create button for condition' do
          expect(page).to have_link("Create Condition")
        end

        scenario 'I view an edit button for each condition' do
          expect(page).to have_link("Edit")
        end

        scenario 'I view a delete button for each condition' do
          expect(page).to have_link("Delete")
        end

        scenario 'I view everything else a user sees' do
          expect(page).to have_content("Date: #{condition_1.date.strftime("%m/%d/%Y")}")
          expect(page).to have_content("Max Temperature: #{condition_1.max_temp}")
          expect(page).to have_content("Mean Temperature: #{condition_1.mean_temp}")
          expect(page).to have_content("Min Temperature: #{condition_1.min_temp}")
          expect(page).to have_content("Mean Humidity: #{condition_1.mean_humidity}")
          expect(page).to have_content("Mean Visibility: #{condition_1.mean_visibility}")
          expect(page).to have_content("Mean Wind Speed: #{condition_1.mean_wind_speed}")
          expect(page).to have_content("Precipitation: #{condition_1.precip}")

          expect(page).to have_content("Date: #{condition_2.date.strftime("%m/%d/%Y")}")
          expect(page).to have_content("Max Temperature: #{condition_2.max_temp}")
          expect(page).to have_content("Mean Temperature: #{condition_2.mean_temp}")
          expect(page).to have_content("Min Temperature: #{condition_2.min_temp}")
          expect(page).to have_content("Mean Humidity: #{condition_2.mean_humidity}")
          expect(page).to have_content("Mean Visibility: #{condition_2.mean_visibility}")
          expect(page).to have_content("Mean Wind Speed: #{condition_2.mean_wind_speed}")
          expect(page).to have_content("Precipitation: #{condition_2.precip}")
      end
    end
  end

  context 'as default user' do
    scenario 'I can not see admin conditions index' do
      user = User.create!(name: "Ameila Pond", email: "amelia@pond.com", password: "Rory", password_confirmation: "Rory", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit conditions_path

      expect(page).to_not have_content("Admin Conditions")
      expect(page).to_not have_link("Create Condition")
      expect(page).to_not have_link("Edit")
      expect(page).to_not have_link("Delete")
    end
  end
  context 'as visitor' do
    scenario 'I can not see admin conditions index' do

      visit conditions_path

      expect(page).to_not have_content("Admin Conditions")
      expect(page).to_not have_link("Create Condition")
      expect(page).to_not have_link("Edit")
      expect(page).to_not have_link("Delete")
    end
  end
end
