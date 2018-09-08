require 'rails_helper'

describe 'as a user' do
  describe 'when visiting /conditions' do
    condition_1 = Condition.create(date: , max_temp:, mean_temp:, min_temp:, mean_humidity:, mean_visibility:, mean_wind_speed:, precip:)

    visit conditions_path

    expect(page).to have_content("#{condition_1.date}")
    expect(page).to have_content("#{condition_1.max_temp}")
    expect(page).to have_content("#{condition_1.mean_temp}")
    expect(page).to have_content("#{condition_1.min_temp}")
    expect(page).to have_content("#{condition_1.mean_humidity}")
    expect(page).to have_content("#{condition_1.mean_visibility}")
    expect(page).to have_content("#{condition_1.mean_wind_speed}")
    expect(page).to have_content("#{condition_1.precip}")
  end
end