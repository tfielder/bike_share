require 'rails_helper'

describe UserAddress, type: :model do
  describe 'relationships' do
    it {should belong_to(:user)}
    it {should belong_to(:address)}
  end
end
