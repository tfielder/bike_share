require 'rails_helper'

describe 'as a registered user' do
  describe 'when visiting /stations-dashboard' do
    before(:each) do
      user = User.create(name: "Beemo", email: "bmo@email.com", password: "pass", password_confirmation: "pass")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/stations-dashboard'   #rename to route

    end

    it 'shows the Total count of stations' do

    end
    it "shows Average bikes available per station (based on docks)" do

    end
    it "shows Most bikes available at a station (based on docks)" do

    end
    it "shows the Station(s) where the most bikes are available (based on docks) " do

    end
    it "shows the Station(s) where the fewest bikes are available (based on docks)" do

    end
    it "shows Most recently installed station" do

    end
    it "shows the Oldest station" do

    end
  end
end