require 'rails_helper'

describe Order, type: :model do
  describe 'relationships' do
    it {should have_many :order_accessories}
  end
  describe 'instance methods' do
    describe '#accessory_count' do
      it "should return a hash of orders accessories" do
        user = User.create!(name: "Finn", email: "pip@pip.com", password: "123")
        order = user.orders.create!
        accessory1 = order.accessories.create!( image: "holder.jpg",
                                   title: "Bonesin",
                                   description: "Some bones",
                                   price: 13.35
                                  )
        accessory2 = order.accessories.create!( image: "holder.jpg",
                                   title: "Bones",
                                   description: "Some bones",
                                   price: 13.35
                                  )
        order.accessories << accessory2

        expect(order.accessory_count).to eq({accessory1 => 1, accessory2 => 2})
      end
      it "#total_price" do
        user = User.create!(name: "Finn", email: "pip@pip.com", password: "123")
        order = user.orders.create!
        accessory1 = order.accessories.create!( image: "holder.jpg",
                                   title: "Bonesin",
                                   description: "Some bones",
                                   price: 10.00
                                  )
        accessory2 = order.accessories.create!( image: "holder.jpg",
                                   title: "Bones",
                                   description: "Some bones",
                                   price: 10.00
                                  )
        order.accessories << accessory2
        expect(order.total_price).to eq(30.00)
      end
    end
  end
end
