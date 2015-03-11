class FixNeighborhoods < ActiveRecord::Migration
  def change
    drop_table :neighborhoods

    create_table :neighborhoods do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
