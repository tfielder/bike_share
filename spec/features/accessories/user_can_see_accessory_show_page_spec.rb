require "rails_helper"

describe "User visits an accessory show page" do
  context "user is a visitor" do
    it "should show an image, title, description, and price with an add to cart button" do
      accessory = Accessory.create!( image: "holder.jpg",
                                    title: "Bones",
                                    description: "Some bones",
                                    price: 13.35
                                  )
      visit accessory_path(accessory)

      within('.image-holder') do
        expect(page).to have_css("img[src*='holder.jpg']")
      end
      expect(page).to have_content(accessory.title)
      expect(page).to have_content(accessory.description)
      expect(page).to have_content("$#{accessory.price}")
    end
  end
end
