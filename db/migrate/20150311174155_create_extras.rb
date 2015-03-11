class CreateExtras < ActiveRecord::Migration
  def change
    create_table :extras do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
