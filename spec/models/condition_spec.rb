require 'rails_helper'
require 'date'

describe Condition, type: :model do
  describe 'validations' do
    it {should validate_presence_of :date}
    it {should validate_presence_of :max_temp}
    it {should validate_presence_of :mean_temp}
    it {should validate_presence_of :min_temp}
    it {should validate_presence_of :mean_humidity}
    it {should validate_presence_of :mean_visibility}
    it {should validate_presence_of :mean_wind_speed}
    it {should validate_presence_of :precip}
  end
  describe 'methods' do
    it "::condition_on_day()" do
      condition = Condition.create(date:"09/01/2018", max_temp:81.0, mean_temp:76.0, min_temp:41.0, mean_humidity:13.0, mean_visibility:12.0, mean_wind_speed:5.0, precip:0.0)

      expect(Condition.condition_on_date(condition.date).first).to eq(condition)
    end
  end

end
