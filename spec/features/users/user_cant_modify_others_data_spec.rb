require 'rails_helper'

describe 'accessing a user edit page' do
  before(:each) do
    @admin = User.create!(name: "Finn", email: "p@p", password: "123", role: 1)
    @user1 = User.create!(name: "sue", email: "y@y", password: "234")
    @user2 = User.create!(name: "You", email: "q@q.com", password: "345")
  end
  it 'as a registered user' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    visit edit_user_path(@user1)

    expect(page).to have_content("Please enter your info to edit.")
  end
  it 'as a different registered user' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)

    visit edit_user_path(@user1)

    expect(page).to have_content("The page you were looking for doesn't exist.")

  end
  it 'as a visitor' do

    visit edit_user_path(@user1)

    expect(page).to have_content("The page you were looking for doesn't exist.")

  end
  it 'as an admin' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit edit_user_path(@user1)

    expect(page).to have_content("The page you were looking for doesn't exist.")

  end
end