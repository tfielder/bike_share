require 'rails_helper'

describe Order, type: :model do
  describe 'relationships' do
    it {should have_many :order_accessories}
  end
end
