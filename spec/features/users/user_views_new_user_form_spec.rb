require 'rails_helper'

feature 'User views new user form page' do
  context 'when user clicks on create account' do

    before do
      visit login_path
      click_on "Create Account"
    end

    scenario 'user views new user page' do
      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Please enter your info to get started.")
      expect(page).to have_content("Name")
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
      expect(page).to have_content("Password confirmation")
      expect(page).to have_button("Submit")
    end
  end
end
