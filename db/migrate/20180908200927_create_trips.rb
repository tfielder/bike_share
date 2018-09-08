class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.integer :duration
      t.date :start_date
      t.references :start_station, foreign_key: {to_table: :stations}
      t.date :end_date
      t.references :end_station, foreign_key: {to_table: :stations}
      t.date :end_date
      t.integer :bike_id
      t.string :subscription_type
      t.integer :zip_code
    end
  end
end
