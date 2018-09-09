require 'rails_helper'

describe Cart do
  describe 'methods' do
    it 'calculates the total number of items it holds' do

      cart = Cart.new({ 1 => 2, 2 => 3})

      expect(cart.total_count).to eq(5)
    end
  end
end
