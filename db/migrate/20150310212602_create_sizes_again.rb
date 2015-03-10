class CreateSizesAgain < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.string :size, null: false
      t.string :frame_sizes, null: false
      t.string :suggested_height, null: false
    end
  end
end
