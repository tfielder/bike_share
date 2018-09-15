require 'rails_helper'

describe 'Admin views an individual order they see order detail w/ date and address' do
  before(:each) do
    @admin = User.create!(name: "Finn", email: "pip@pip.com", password: "123", role: 1)
    @user1 = User.create!(name: "sue", email: "you@you.com", password: "123")
    @user2 = User.create!(name: "You", email: "p@p.com", password: "123")
    @accessory = Accessory.create!( image: "https://i.kym-cdn.com/photos/images/masonry/000/138/153/voldemort-120-thumb-120x120-34926.jpg",
                       title: "Voldemort",
                       description: "Noseless Racist Wizard",
                       price: 48.50
                    )
    @order = @user1.orders.create!(status: "pending")
    @order.accessories << @accessory

  end
  scenario 'I visit the order show page as an admin'do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

    visit order_path(@order)
    save_and_open_page

    expect(page).to have_content(Order.last.created_at)
    expect(page).to have_content(@user1.name)
  end
end
