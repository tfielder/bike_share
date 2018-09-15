require 'rails_helper'

feature 'Admin edits condition' do
  let!(:condition){Condition.create(date:"09/01/2018", max_temp:80.0, mean_temp:75.0, min_temp:40.0, mean_humidity:12.5, mean_visibility:10.0, mean_wind_speed:10.0, precip:1.0)}

  context 'as an admin on the conditions index page' do

    before do
      admin = User.create!(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit conditions_path
    end

    context 'when I click on Edit' do
      scenario 'it takes me to an edit form' do
        click_on "Edit"

        expect(current_path).to eq(new_admin_condition_path)
        expect(page).to have_content("Edit condition:")
        expect(page).to have_content("Date:")
        expect(page).to have_content("Max temp:")
        expect(page).to have_content("Mean temp:")
        expect(page).to have_content("Min temp:")
        expect(page).to have_content("Mean humidity:")
        expect(page).to have_content("Mean visibility:")
        expect(page).to have_content("Mean wind speed:")
        expect(page).to have_content("Precip:")
      end
      context 'when I update the form and click submit' do
        scenario 'it updates a condition' do
          click_on "Edit"


          click_on "Submit Changes"
          condition.reload

          expect(current_path).to eq(condition_path(condition))

          expect(page).to have_content("Successfully updated!")
        end
      end
    end
  end
  context 'as an admin on the conditions show page' do

    before do
      admin = User.create!(name: "Dr.Who", email: "thedoctor@tardis.com", password: "blue", password_confirmation: "blue", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit condition_path(condition)
    end

    context 'when I click on Edit' do
      scenario 'it takes me to an edit form' do
        click_on "Edit"

        expect(current_path).to eq(new_admin_condition_path)
        expect(page).to have_content("Edit condition:")
        expect(page).to have_content("Date:")
        expect(page).to have_content("Max temp:")
        expect(page).to have_content("Mean temp:")
        expect(page).to have_content("Min temp:")
        expect(page).to have_content("Mean humidity:")
        expect(page).to have_content("Mean visibility:")
        expect(page).to have_content("Mean wind speed:")
        expect(page).to have_content("Precip:")
      end
      context 'when I update the form and click submit' do
        scenario 'it updates a condition' do
          click_on "Edit"
          fill_in :condition_min_temp, with: 47.8
          click_on "Submit Changes"
          condition.reload

          expect(current_path).to eq(condition_path(condition))
          expect(:condition_min_temp).to eq(47.8)
          expect(page).to have_content("#{47.8}")
          expect(page).to_not have_content("#{40.0}")
          expect(page).to have_content("Successfully updated!")
        end
      end
    end
  end
  context 'as default user' do
    before do
      user = User.create!(name: "Evil Hacker", email: "hacker@email.com", password: "hack", password_confirmation: "hack", role: 0)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit edit_admin_condition_path(condition)
    end
    scenario 'I cannot see the edit condition page' do
      expect(page).to_not have_content("Edit condition:")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
  context 'as visitor' do
    before do
      visit edit_admin_condition_path(condition)
    end
    scenario 'I cannot see the edit condition page' do
      expect(page).to_not have_content("Edit condition:")
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

end
