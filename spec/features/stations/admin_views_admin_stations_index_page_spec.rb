require 'rails_helper'
# As an admin user,
# When I visit the stations index,
# I see everything a visitor can see,
# I see a button next to each station to edit that station,
# I also see a button next to each station to delete that station.

feature 'Admin views admin stations index page' do
  context 'Admin views edit and delete buttons for each station' do
    context 'as an admin on the stations index page' do

      before do
        admin = User.create!(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
        station1 = Station.create( name:              "San Jose Diridon Caltrain Station",
                                  dock_count:        27,
                                  city:              "San Jose",
                                  installation_date: "8/6/2013",
                                )
        station2 = Station.create(name:              "San Jose Civic Center",
                                  dock_count:        15,
                                  city:              "San Jose",
                                  installation_date: "8/5/2013",
                                )
        station3 = Station.create(name:              "Santa Clara",
                                  dock_count:        11,
                                  city:              "San Jose",
                                  installation_date: "8/6/2013",
                                )

        visit admin_stations_path
      end

      scenario 'I am on the admin stations index page' do
        expect(current_path).to eq(admin_stations_path)
        expect(page).to have_content("Admin Stations")
      end

      scenario 'I view an edit button for each station' do
        expect(page).to have_link("Edit")
        expect(page).to have_link("Delete")
      end

      scenario 'I view a delete button for each station' do
        expect(page).to have_link("Delete")
      end

      scenario 'I view everything else a user sees' do
        expect(page).to have_link(station1.name)
        expect(page).to have_content(station1.dock_count)
        expect(page).to have_content(station1.city)
        expect(page).to have_content(station1.installation_date)
        expect(page).to have_link(station2.name)
        expect(page).to have_content(station2.dock_count)
        expect(page).to have_content(station2.city)
        expect(page).to have_content(station2.installation_date)
        expect(page).to have_link(station3.name)
        expect(page).to have_content(station3.dock_count)
        expect(page).to have_content(station3.city)
        expect(page).to have_content(station3.installation_date)
      end
    end
  end
  context 'as default user' do
    scenario 'I can not see admin stations index' do
      user = User.create!(name: "Ameila Pond", email: "amelia@pond.com", password: "Rory", password_confirmation: "Rory", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_stations_path

      expect(page).to_not have_content("Admin Stations")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
