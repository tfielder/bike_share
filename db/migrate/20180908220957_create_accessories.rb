class CreateAccessories < ActiveRecord::Migration[5.1]
  def change
    create_table :accessories do |t|
      t.string :image
      t.string :title
      t.string :description
      t.float :price
      t.timestamps
    end
  end
end
