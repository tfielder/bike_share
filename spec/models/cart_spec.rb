require 'rails_helper'

describe Cart do
  describe 'methods' do
    subject { Cart.new({ 1 => 2, 2 => 3})}

    it 'calculates the total number of items it holds' do

      expect(subject.total_count).to eq(5)
    end

    it 'adds accessories to contents' do
      subject.add_accessory(1)
      subject.add_accessory(2)

      expect(subject.contents).to eq({ 1 => 3, 2 => 4})
    end
  end
end
