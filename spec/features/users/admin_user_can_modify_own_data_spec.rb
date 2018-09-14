require 'rails_helper'

describe 'as an admin' do
  describe 'from the edit_account' do
    before(:each) do
      @admin = User.create!(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)
      @admin2 = User.create!(name: "Dr.What", email: "theotherdoctor@tardis.com", password: "red", password_confirmation: "red", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin2)
    end
    it 'allows user to modify account data' do
      visit edit_user_path(@admin2)

      fill_in :user_name, with: "Herb"
      fill_in :user_email, with: "broski@broski.com"
      fill_in :user_password, with: "red"
      fill_in :user_password_confirmation, with: "red"

      click_on "Submit"

      expect(current_path).to eq(admin_dashboard_path)
      @admin2.reload
      expect(@admin2.name).to eq("Herb")
      expect(@admin2.email).to eq("broski@broski.com")
    end
    it 'does not allow user to modify other user account data' do

    end
  end
end
