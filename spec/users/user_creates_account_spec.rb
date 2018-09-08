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
          scenario 'I view a form for creating an account' do
            
            visit login_path
            click_on "Create Account"
            expect(current_path).to eq(new_user_path)
          end
        end
      end
    end
  end
end
