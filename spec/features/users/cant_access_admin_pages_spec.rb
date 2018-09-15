require 'rails_helper'

describe 'as a user' do
  before(:each) do
    @admin = User.create!(name: "Finn", email: "pip@pip.com", password: "123", role: 1)
    @user1 = User.create!(name: "sue", email: "you@you.com", password: "123")

    @order = @admin.orders.create!(status: "completed")

  end
  describe 'cannot view admin dash' do
    scenario 'as a visitor' do
      visit admin_dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    xscenario 'as a user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit admin_dashboard_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
  describe 'cannot view admin trips pages' do
    xscenario 'as a visitor' do
      visit new_admin_trip_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    xscenario 'as a user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit new_admin_trip_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
  describe 'cannot view admin conditions pages' do
    xscenario 'as a visitor' do
      visit new_admin_condition_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    xscenario 'as a user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit new_admin_condition_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
  describe 'cannot view admin stations pages' do
    xscenario 'as a visitor' do
      visit new_admin_station_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
    xscenario 'as a user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit new_admin_station_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end