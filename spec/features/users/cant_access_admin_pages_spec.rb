require 'rails_helper'

describe 'as a user' do
  before(:each) do
    @admin = User.create!(name: "Finn", email: "pip@pip.com", password: "123", role: 1)
    @user1 = User.create!(name: "sue", email: "you@you.com", password: "123")

    @condition_1 = Condition.create(date:"09/01/2018", max_temp:80.0, mean_temp:75.0, min_temp:40.0, mean_humidity:12.5, mean_visibility:10.0, mean_wind_speed:10.0, precip:1.0)
    @station_1 = Station.create(
                                name:             "San Jose Diridon Caltrain Station",
                                dock_count:                                          27,
                                city:                                        "San Jose",
                                installation_date: Date.strptime("8/6/2015", "%m/%d/%Y"))
    @station_2 = Station.create(
                                name:             "San Jose Diridon Caltrain Station",
                                dock_count:                                          27,
                                city:                                        "San Jose",
                                installation_date: Date.strptime("8/6/2015", "%m/%d/%Y"))
    @trip_1 = Trip.create(duration: 42, start_date:Date.strptime("09/01/2018",'%m/%d/%Y'), start_station: @station_1, end_date:Date.strptime("09/01/2018",'%m/%d/%Y'), end_station: @station_2,bike_id: 2, subscription_type:"Subsciber", zip_code: 94127 )
    @order = @admin.orders.create!(status: "completed")
  end
  describe 'cannot view admin dash' do
    scenario 'as a visitor' do
      visit admin_dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    scenario 'as a user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit admin_dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
  describe 'cannot view admin trips pages' do
    scenario 'as a visitor' do
      visit edit_admin_trip_path(@trip_1)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    scenario 'as a user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit edit_admin_trip_path(@trip_1)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
  describe 'cannot edit a trip' do ##
    scenario 'as a visitor' do
      visit trip_path(@trip_1)
      expect(page).to_not have_content("Edit")
      expect(page).to_not have_content("Delete")
    end
    scenario 'as a user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit trip_path(@trip_1)
      expect(page).to_not have_content("Edit")
      expect(page).to_not have_content("Delete")
    end
  end
  describe 'cannot view admin conditions pages' do
    scenario 'as a visitor' do
      visit edit_admin_condition_path(@condition_1)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    scenario 'as a user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit edit_admin_condition_path(@condition_1)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
  describe 'cannot edit a condition' do
    scenario 'as a visitor' do
      visit condition_path(@condition_1)
      expect(page).to_not have_content("Edit")
      expect(page).to_not have_content("Delete")
    end
    scenario 'as a user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit condition_path(@condition_1)
      expect(page).to_not have_content("Edit")
      expect(page).to_not have_content("Delete")
    end
  end
  describe 'cannot view admin stations pages' do
    scenario 'as a visitor' do
      visit edit_admin_station_path(@station_1)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    scenario 'as a user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit edit_admin_station_path(@station_1)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
  describe 'cannot edit a station' do
    scenario 'as a visitor' do
      visit station_path(@station_1)
      expect(page).to_not have_content("Edit")
      expect(page).to_not have_content("Delete")
    end
    scenario 'as a user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit station_path(@station_1)
      expect(page).to_not have_content("Edit")
      expect(page).to_not have_content("Delete")
    end
  end
end