require 'rails_helper'

feature 'Registered user can log in' do
  context 'as a registered user' do
    let!(:user) {User.create!(name: "Beemo", email: "bmo@email.com", password: "pass", password_confirmation: "pass")}

    before do
      visit root_path
      click_on "Log In"
    end

    scenario 'I can log in when I fill out the right info' do
      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on "Submit"

      expect(current_path).to eq(dashboard_path)
      expect(user.name).to eq("Beemo")
    end

      scenario 'I view my profile and user nav bar as a logged in user' do

        fill_in :email, with: user.email
        fill_in :password, with: user.password

        click_on "Submit"

        within(".navbar") do
          expect(page).to have_content("Logged in as #{user.name}")
          expect(page).to have_content("Log Out")
          expect(page).to_not have_content("Log In")
        end
      end

    scenario 'I cannot login when I fill in the wrong email' do
      fill_in :email, with: "wrong@email.com"
      fill_in :password, with: user.password

      click_on "Submit"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Incorrect email or password, please try again")
    end

    scenario 'I cannot login when I fill in the wrong password' do
      fill_in :email, with: user.email
      fill_in :password, with: "wrong"

      click_on "Submit"

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Incorrect email or password, please try again")
    end
  end
end
