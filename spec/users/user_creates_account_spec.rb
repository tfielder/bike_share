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
    end
  end
end
