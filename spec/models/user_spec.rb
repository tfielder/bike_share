require 'rails_helper'
describe User, type: :model do
  describe 'validations' do
    xit {should validate_presence_of(:name)}
    xit {should validate_presence_of(:email)}
    xit {should validate_uniqueness_of(:email)}
    xit {should validate_presence_of(:password)}
  end

  describe 'roles' do
    xit 'can be created as a default user' do
      user = User.create(name: "underling", email: 'underling@email.com')

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end
  end
end
