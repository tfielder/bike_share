require "rails_helper"

describe 'User visits a station show page' do
  context 'User is a visitor' do
    it 'should show station attributes' do
      station = Station.create( name:              "San Jose Diridon Caltrain Station",
                                dock_count:        27,
                                city:              "San Jose",
                                installation_date: Date.strptime("8/6/2013", "%m/%d/%Y")
                              )

      visit station_path(station)

      expect(current_path).to eq("/san-jose-diridon-caltrain-station")
      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)
    end
  end
end
