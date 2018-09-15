require 'rails_helper'

feature 'Admin creates trip' do
  let!(:station_1){Station.create(name:'Archer station', dock_count: 10, city: 'Seattle', installation_date: Date.strptime('07/08/2011', '%m/%d/%Y'))}
  let!(:station_2){Station.create(name:'Lana station', dock_count: 8, city: 'Montreal', installation_date: Date.strptime('11/22/2016', '%m/%d/%Y'))}

  context 'as an admin' do
    before do
      admin = User.create!(name: 'Pam', email: 'pam@agent.com', password: '007', password_confirmation: '007', role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit trips_path
    end

    context 'when I click on Create Trip' do
      scenario 'it takes me to a new trip form' do
        click_on 'Create Trip'

        expect(current_path).to eq(new_admin_trip_path)
        expect(page).to have_content("Create a new trip:")
        expect(page).to have_content("Duration:")
        expect(page).to have_content("Start station:")
        expect(page).to have_content("Start date:")
        expect(page).to have_content("End station:")
        expect(page).to have_content("End date:")
        expect(page).to have_content("Bike:")
        expect(page).to have_content("Subscription type:")
        expect(page).to have_content("Zip code:")
        expect(page).to have_button("Submit")
      end
      context 'when I fill in the form and click submit' do
        scenario 'it creates a trip' do
          click_on "Create Trip"

          fill_in :trip_duration, with: 123
          page.select("Lana station", from: :trip_start_station_id)
          fill_in "Start date", :with => "12/23/2015"
          page.select("Archer station", from: :trip_end_station_id)
          fill_in "End date", :with => '1/29/2016'
          fill_in :trip_bike_id, with: 79
          fill_in :trip_subscription_type, with: "Shabam"
          fill_in :trip_zip_code, with: ""
          
          click_on "Submit"

          trip = Trip.last
          expect(current_path).to eq(trip_path(trip))
          expect(page).to have_content("Successfully created trip ##{trip.id}!")
          expect(page).to have_content(trip.duration)
          expect(page).to have_content(trip.duration)
          expect(page).to have_content(station_1.name)
          expect(page).to have_content(station_2.name)
          expect(page).to have_content(trip.start_date.strftime("%m/%d/%Y"))
          expect(page).to have_content(trip.end_date.strftime("%m/%d/%Y"))
          expect(page).to have_content(trip.bike_id)
          expect(page).to have_content(trip.subscription_type)
        end
      end
    end
  end
  context 'as a default user' do
    before do
      user = User.create!(name: "Cyril", email: "cyril@agent.com", password: "123", password_confirmation: "123", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit new_admin_trip_path
    end
    scenario 'I cannot view the new trip page if I tried' do
      expect(page).to_not have_content("Create a new trip:")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
  context 'as a visitor' do
    before do
      visit new_admin_trip_path
    end
    scenario 'I cannot view the new trip page if I tried' do
      expect(page).to_not have_content("Create a new trip:")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
