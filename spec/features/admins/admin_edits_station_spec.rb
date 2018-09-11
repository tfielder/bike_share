require 'rails_helper'

feature 'Admin edits station' do
  let!(:station) { Station.create(name:              "San Jose Diridon Caltrain Station",
                                  dock_count:        27,
                                  city:              "San Jose",
                                  installation_date: "8/6/2013",
                                  )}
  context 'as an admin' do

    before do
      admin = User.create!(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit admin_stations_path
    end

    context 'when I click on Edit' do
      scenario 'it takes me to an edit form' do
        click_on "Edit"
        expect(current_path).to eq(edit_admin_station_path(station))
        expect(page).to have_content("Edit #{station.name}")
        expect(page).to have_content("Name:")
        expect(page).to have_content("Dock count:")
        expect(page).to have_content("City:")
        expect(page).to have_content("Installation date:")
      end
      context 'when I update the form and click submit' do
        xscenario 'it updates a station' do
        end
      end
    end
  end
end
