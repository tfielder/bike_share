class AddSlugToAccessories < ActiveRecord::Migration[5.1]
  def change
    add_column :accessories, :slug, :string
  end
end
