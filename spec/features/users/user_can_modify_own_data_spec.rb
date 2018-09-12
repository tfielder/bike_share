require 'rails_helper'

describe 'As a registered user' do
  before(:each) do
    user1 = User.create(name: "Beemo", email: "bmo@email.com", password: "pass", password_confirmation: "pass")
    user2 = User.create(name: "Zebra", email: "zebra@email.com", password: "test", password_confirmation: "test")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
  end
  describe 'from user dashboard, can access edit_account_path' do
    visit dashboard_path

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_button("Edit Account")

    click_on "Edit Account"

    expect(current_path).to eq(user_edit_path)
  end
  describe 'from the edit_account' do
    it 'allows user to modify account data' do

    end
    it 'does not allow user to modify other user account data' do

    end
  end
end
describe 'as an admin' do
  before(:each) do
    admin = User.create(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)
    admin2 = User.create(name: "Dr.What", email: "theotherdoctor@tardis.com", password: "red", password_confirmation: "wrong", role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit login_path
  end
  describe 'from the edit_account' do
    it 'allows user to modify account data' do

    end
    it 'does not allow user to modify other user account data' do

    end
  end
end