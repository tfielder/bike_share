require 'rails_helper'

describe 'As a visitor' do
  before(:each) do
    @item_1 = Accessory.create(title: "happy1", image: "image1", description: "sogood1", price: 10.01)
    @item_2 = Accessory.create(title: "happy2", image: "image2", description: "sogood2", price: 10.02)
    @item_3 = Accessory.create(title: "happy3", image: "image3", description: "sogood3", price: 10.03)
    @item_4 = Accessory.create(title: "happy4", image: "image4", description: "sogood4", price: 10.04)
    @item_5 = Accessory.create(title: "happy5", image: "image5", description: "sogood5", price: 10.05)
    @item_6 = Accessory.create(title: "happy6", image: "image6", description: "sogood6", price: 10.06)
    @item_7 = Accessory.create(title: "happy7", image: "image7", description: "sogood7", price: 10.07)
    @item_8 = Accessory.create(title: "happy8", image: "image8", description: "sogood8", price: 10.08)
    @item_9 = Accessory.create(title: "happy9", image: "image9", description: "sogood9", price: 10.09)
    @item_10 = Accessory.create(title: "happy10", image: "image10", description: "sogood10", price: 10.10)
    @item_11 = Accessory.create(title: "happy11", image: "image11", description: "sogood11", price: 10.20)
    @item_12 = Accessory.create(title: "happy12", image: "image12", description: "sogood12", price: 10.30)

    visit bike_shop_path
  end
  describe 'visiting /bike_shop' do
    it 'shows at least 12 bike accessories for sale' do
      expect(page).to have_content("#{@item_1.title}")
      expect(page).to have_content("#{@item_1.description}")
      expect(page).to have_content("#{@item_1.price}")
      expect(page).to have_content("#{@item_2.title}")
      expect(page).to have_content("#{@item_2.description}")
      expect(page).to have_content("#{@item_2.price}")
      expect(page).to have_content("#{@item_3.title}")
      expect(page).to have_content("#{@item_3.description}")
      expect(page).to have_content("#{@item_3.price}")
      expect(page).to have_content("#{@item_4.title}")
      expect(page).to have_content("#{@item_4.description}")
      expect(page).to have_content("#{@item_4.price}")
      expect(page).to have_content("#{@item_5.title}")
      expect(page).to have_content("#{@item_5.description}")
      expect(page).to have_content("#{@item_5.price}")
      expect(page).to have_content("#{@item_6.title}")
      expect(page).to have_content("#{@item_6.description}")
      expect(page).to have_content("#{@item_6.price}")
      expect(page).to have_content("#{@item_7.title}")
      expect(page).to have_content("#{@item_8.title}")
      expect(page).to have_content("#{@item_9.title}")
      expect(page).to have_content("#{@item_10.title}")
      expect(page).to have_content("#{@item_11.title}")
      expect(page).to have_content("#{@item_12.title}")
    end
    it 'shows a button near each item that says add to cart' do
      expect(page).to have_button("Add to Cart")
    end
  end
end
