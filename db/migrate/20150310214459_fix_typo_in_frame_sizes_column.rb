class FixTypoInFrameSizesColumn < ActiveRecord::Migration
  def change
    rename_column :sizes, :frame_sizes, :frame_size
  end
end
