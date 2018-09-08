class ChangeDateToDateTimeInConditions < ActiveRecord::Migration[5.1]
  def change
    change_column :conditions, :date, :datetime
  end
end
