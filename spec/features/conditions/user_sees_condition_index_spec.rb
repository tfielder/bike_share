require 'rails_helper'

describe 'as a user' do
  describe 'when visiting /conditions' do
    it 'shows all conditions on index page' do
      condition_1 = Condition.create(date:"09/01/2018", max_temp:80.0, mean_temp:75.0, min_temp:40.0, mean_humidity:12.5, mean_visibility:10.0, mean_wind_speed:10.0, precip:1.0)

      visit conditions_path

      expect(page).to have_content("Date: #{condition_1.date}")
      expect(page).to have_content("Max Temperature: #{condition_1.max_temp}")
      expect(page).to have_content("Mean Temperature: #{condition_1.mean_temp}")
      expect(page).to have_content("Min Temperature: #{condition_1.min_temp}")
      expect(page).to have_content("Mean Humidity: #{condition_1.mean_humidity}")
      expect(page).to have_content("Mean Visibility: #{condition_1.mean_visibility}")
      expect(page).to have_content("Mean Wind Speed: #{condition_1.mean_wind_speed}")
      expect(page).to have_content("Precipitation: #{condition_1.precip}")
    end
  end
end