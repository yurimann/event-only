class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :city
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
