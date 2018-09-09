require 'rails_helper'
# I see a message in the navbar that says "Logged in as SOME_USER",
# I see my profile information,
# I do not see a link for "Login",
# I also see a link for "Logout".
feature 'Registered user can log in' do
  context 'as a registered user' do
    context 'when I can click on login' do
      scenario 'I am logged in' do
        user = User.create!(name: "Beemo", email: "bmo@email.com", password: "pass", password_confirmation: "pass")

        visit root_path

        click_on "Log In"

        fill_in :email, with: user.email
        fill_in :password, with: user.password

        click_on "Submit"

        expect(current_path).to eq(dashboard_path)
        expect(user.name).to eq("Beemo")
      end
      scenario 'I view my profile and user nav bar' do
        user = User.create!(name: "Beemo", email: "bmo@email.com", password: "pass", password_confirmation: "pass")

        visit root_path

        click_on "Log In"

        fill_in :email, with: user.email
        fill_in :password, with: user.password

        click_on "Submit"

        within(".navbar") do
          expect(page).to have_content("Logged in as #{user.name}")
          expect(page).to have_content("Log Out")
          expect(page).to_not have_content("Log In")
        end
      end
    end
  end
end
