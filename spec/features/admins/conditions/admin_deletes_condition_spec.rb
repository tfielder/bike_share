require 'rails_helper'

feature 'Admin deletes condition' do
  let!(:deleted_condition){Condition.create(date:"09/02/2018", max_temp:81.0, mean_temp:76.0, min_temp:41.0, mean_humidity:13.0, mean_visibility:12.0, mean_wind_speed:5.0, precip:0.0)}

    context 'as admin' do
      before do
        admin = User.create!(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      end

      context 'on the condition index page' do
        before do
          visit conditions_path
        end
          scenario 'admin can delete a condition' do
            click_on "Delete"

            expect(current_path).to eq(conditions_path)
            expect(page).to have_content("Successfully deleted.")
            expect(page).to_not have_content("Date: #{deleted_condition.date.strftime("%m/%d/%Y")}")
            expect(page).to_not have_content("Max Temperature: #{deleted_condition.max_temp}")
            expect(page).to_not have_content("Mean Temperature: #{deleted_condition.mean_temp}")
            expect(page).to_not have_content("Min Temperature: #{deleted_condition.min_temp}")
            expect(page).to_not have_content("Mean Humidity: #{deleted_condition.mean_humidity}")
            expect(page).to_not have_content("Mean Visibility: #{deleted_condition.mean_visibility}")
            expect(page).to_not have_content("Mean Wind Speed: #{deleted_condition.mean_wind_speed}")
            expect(page).to_not have_content("Precipitation: #{deleted_condition.precip}")
          end
      end

      context 'on the condition show page' do
        before do
          visit condition_path(deleted_condition)
        end

          scenario 'admin can delete a condition' do
            click_on "Delete"
            expect(current_path).to eq(conditions_path)
            expect(page).to have_content("Successfully deleted.")

            expect(page).to_not have_content("Date: #{deleted_condition.date.strftime("%m/%d/%Y")}")
            expect(page).to_not have_content("Max Temperature: #{deleted_condition.max_temp}")
            expect(page).to_not have_content("Mean Temperature: #{deleted_condition.mean_temp}")
            expect(page).to_not have_content("Min Temperature: #{deleted_condition.min_temp}")
            expect(page).to_not have_content("Mean Humidity: #{deleted_condition.mean_humidity}")
            expect(page).to_not have_content("Mean Visibility: #{deleted_condition.mean_visibility}")
            expect(page).to_not have_content("Mean Wind Speed: #{deleted_condition.mean_wind_speed}")
            expect(page).to_not have_content("Precipitation: #{deleted_condition.precip}")
          end
      end
    end
end
