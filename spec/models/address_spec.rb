require 'rails_helper'

describe Address, type: :model do
  describe 'validations' do
  it { should validate_presence_of :address}
  end

  describe 'relationships' do
    it {should have_many(:users)}
    it {should have_many(:user_addresses)}
  end
end
