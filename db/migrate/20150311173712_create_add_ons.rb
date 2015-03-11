class CreateAddOns < ActiveRecord::Migration
  def change
    create_table :add_ons do |t|
      t.integer :bike_id
      t.integer :extra_id

      t.timestamps null: false
    end

    add_index :add_ons, :bike_id
    add_index :add_ons, :extra_id
  end
end
