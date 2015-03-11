class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.integer :owner_id, null: false
      t.string :name, null: false
      t.string :type, null: false
      t.text :notes
      t.string :gender, null: false
      t.integer :size_id, null: false
      t.integer :num_gears, null: false
      t.integer :hourly_price, null: false

      t.timestamps null: false
    end
  end
end
