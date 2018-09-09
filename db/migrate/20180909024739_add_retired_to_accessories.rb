class AddRetiredToAccessories < ActiveRecord::Migration[5.1]
  def change
    add_column :accessories, :retired, :boolean, default: false
  end
end
