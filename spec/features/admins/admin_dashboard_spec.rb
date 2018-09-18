require 'rails_helper'


describe "Admin visits their dashboard" do
  before(:each) do
    @user1 = User.create!( name: "test",
                  email: "test@test",
                  password: "test",
                  password_confirmation: "test",
                  role: 0
                )
    @user2 = User.create!( name: "test2",
                  email: "test2@test2",
                  password: "test2",
                  password_confirmation: "test2",
                  role: 0
                )
    @admin = User.create!( name: "Ben",
                  email: "ben1@ben1.com",
                  password: "123",
                  password_confirmation: "123",
                  role: 1
                )
    @user1.addresses.create!(address: "1300 Hogwarts Drive Hogwarts, CA 90210")
    @user2.addresses.create!(address: "1300 Hogwarts Drive Hogwarts, CA 90210")
    @admin.addresses.create!(address: "1300 Hogwarts Drive Hogwarts, CA 90210")

    @order1 = @user1.orders.create!(status: "ordered")
    @order2 = @user1.orders.create!(status: "paid")
    @order3 = @user2.orders.create!(status: "cancelled")
    @order4 = @user2.orders.create!(status: "completed")

    @user1.addresses.create(address: "creamy fields")
    @user2.addresses.create(address: "creamy fields")
    @admin.addresses.create(address: "creamy fields")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    visit admin_dashboard_path
  end
  describe "dashboard should show all orders" do
    it "should show all orders and link to order" do
      expect(page).to have_link(@order1.id)
      expect(page).to have_link(@order2.id)
      expect(page).to have_link(@order3.id)
      expect(page).to have_link(@order4.id)

      click_on "#{@order1.id}"

      expect(current_path).to eq(order_path(@order1))
    end
    it "should have crud buttons" do
      expect(page).to have_button("Mark as Paid")
      expect(page).to have_button("Mark as Completed")
      expect(page).to have_button("Cancel")
    end
    it "cancel should remove an order and keep a mark as completed" do
      click_on "Mark as Completed"
      click_on "Cancel"

      expect(current_path).to eq(admin_dashboard_path)

      expect(page).to have_link(@order1.id)
      expect(page).to have_link(@order2.id)
    end
    it "can filter based on status" do
      click_on "Ordered Status"
      expect(page).to have_link(@order1.id)
      expect(page).to_not have_link(@order2.id)
      expect(page).to_not have_link(@order3.id)
      expect(page).to_not have_link(@order4.id)

      click_on "Paid Status"
      expect(page).to_not have_link(@order1.id)
      expect(page).to have_link(@order2.id)
      expect(page).to_not have_link(@order3.id)
      expect(page).to_not have_link(@order4.id)

      click_on "Cancelled Status"
      expect(page).to_not have_link(@order1.id)
      expect(page).to_not have_link(@order2.id)
      expect(page).to have_link(@order3.id)
      expect(page).to_not have_link(@order4.id)

      click_on "Completed Status"
      expect(page).to_not have_link(@order1.id)
      expect(page).to_not have_link(@order2.id)
      expect(page).to_not have_link(@order3.id)
      expect(page).to have_link(@order4.id)
    end
    it "should show Admin's personal information" do
      expect(page).to have_content(@admin.addresses.first.address)
      expect(page).to have_content(@admin.name)
    end
  end
end
