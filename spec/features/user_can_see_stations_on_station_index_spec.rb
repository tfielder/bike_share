require "rails_helper"

describe 'User visits the stations index page' do
  context 'User is a visitor' do
    it 'should show all stations and their attributes' do
      station1 = Station.create(name:              "San Jose Diridon Caltrain Station",
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

      visit stations_path

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
