require 'rails_helper'

describe 'as a registered user' do
  describe 'when visiting /stations-dashboard' do
    before(:each) do
      user = User.create(name: "Beemo", email: "bmo@email.com", password: "pass", password_confirmation: "pass")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      station1 = Station.create(name:              "San Jose Diridon Caltrain Station",
                                dock_count:        27,
                                city:              "San Jose",
                                installation_date: Date.strptime("8/6/2013", "%m/%d/%Y")
                              )
      station2 = Station.create(name:              "San Jose Civic Center",
                                dock_count:        15,
                                city:              "San Jose",
                                installation_date: Date.strptime("8/5/2014", "%m/%d/%Y")
                              )
      station3 = Station.create(name:              "Santa Clara",
                                dock_count:        11,
                                city:              "San Jose",
                                installation_date: Date.strptime("8/6/2015", "%m/%d/%Y")
                              )

      visit stations_dashboard_path
    end

    it 'shows the Total count of stations' do
      expect(page).to have_content("Total Stations Count: #{@count}")
    end
    it "shows Average bikes available per station (based on docks)" do
      expect(page).to have_content("Average Bikes Available Per Station: #{@average}")
    end
    it "shows Most bikes available at a station (based on docks) and where most bikes available" do
      expect(page).to have_content("Most Bikes Available: #{@most_bikes} at Station: #{@station_most_bikes}")
    end
    it "shows the Station(s) where the fewest bikes are available (based on docks)" do
      expect(page).to have_content("Fewest Bikes Available: #{@least_bikes} at Station: #{@station_least_bikes}")
    end
    it "shows Most recently installed station" do
      expect(page).to have_content("Newest Installed Station: #{@newest_station}")
    end
    it "shows the Oldest station" do
      save_and_open_page
      expect(page).to have_content("Oldest Installed Station: #{@oldest_station}")
    end
  end
end