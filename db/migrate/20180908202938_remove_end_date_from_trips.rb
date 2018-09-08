class RemoveEndDateFromTrips < ActiveRecord::Migration[5.1]
  def change
    remove_column :trips, :end_date, :date
  end
end
