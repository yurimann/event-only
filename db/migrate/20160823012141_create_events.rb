class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :location_id
      t.date :date
      t.integer :capacity

      t.timestamps
    end
  end
end
