class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :requestor_id, null: false
      t.integer :bike_id, null: false
      t.date :start_date, null: false
      t.time :start_time, null: false
      t.date :end_date, null: false
      t.time :end_time, null: false
      t.boolean :approved

      t.timestamps null: false
    end
  end
end
