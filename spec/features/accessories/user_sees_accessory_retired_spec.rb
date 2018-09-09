require "rails_helper"

describe "User visits an accessory show page" do
  context "user is a visitor" do
    it "should show accessory retired if :retired is true" do
      accessory1 = Accessory.create!( image: "holder.jpg",
                                    title: "Bones",
                                    description: "Some bones",
                                    price: 13.35
                                  )
      accessory2 = Accessory.create!( image: "holder.jpg",
                                    title: "Bonesin",
                                    description: "Some bones",
                                    price: 13.35,
                                    retired: true
                                  )

      visit accessory_path(accessory1)
      expect(page).to have_link("Add To Cart")
      expect(page).to_not have_content("Accessory Retired")

      visit accessory_path(accessory2)
      expect(page).to_not have_link("Add To Cart")
      expect(page).to have_content("Accessory Retired")
    end
  end
end
