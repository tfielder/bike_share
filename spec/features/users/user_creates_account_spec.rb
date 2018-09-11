require 'rails_helper'

feature 'New user can create an account' do
  context 'As a visitor' do
    context 'when I visit "/" and click on Log In' do
      scenario 'I am on the "/login" page and view link to Create Account' do
        visit root_path

        click_on "Log In"

        expect(current_path).to eq(login_path)
        expect(page).to have_link("Create Account")
      end
    context 'on the login page' do
        context 'I click on Create Account' do
          context 'I fill out form and click submit' do
            scenario 'I create a new user account' do

              visit login_path

              click_on "Create Account"

              expect(current_path).to eq(new_user_path)

              fill_in :user_name, with: "Finn"
              fill_in :user_email, with: "finn@jake.com"
              fill_in :user_password, with: "123"
              fill_in :user_password_confirmation, with: "123"

              click_on "Submit"

              user = User.last

              expect(user.name).to eq("Finn")
              expect(user.email).to eq("finn@jake.com")
              expect(page).to have_content("Welcome to Bike Share #{user.name}")
              expect(current_path).to eq(dashboard_path)
            end
          end

          context 'I fill out form with a previously used email' do
            let!(:user) {User.create!(name:"Jake", email:"same@email.com", password: "123", password_confirmation: "123")}
            context 'I click submit' do
              scenario 'I can not create a new user account' do

                visit login_path

                click_on "Create Account"

                expect(current_path).to eq(new_user_path)

                fill_in :user_name, with: "Finn"
                fill_in :user_email, with: "same@email.com"
                fill_in :user_password, with: "123"
                fill_in :user_password_confirmation, with: "123"

                click_on "Submit"

                expect(page).to have_content("Name")
                expect(page).to have_content("Email")
                expect(page).to have_content("Password")
                expect(page).to have_content("Password confirmation")
                expect(current_path).to eq(users_path)
                expect(page).to have_content("Please try again.")
              end
            end
          end
        end
      end
    end
  end
end
