require 'rails_helper'

feature 'User views login page' do
  context 'when user clicks on log in' do

    before do
      visit root_path
      click_on "Log In"
    end

    scenario 'user views login page' do
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Email:")
      expect(page).to have_content("Password:")
      expect(page).to have_button("Submit")
      expect(page).to have_link("Create Account")
    end
  end
end
