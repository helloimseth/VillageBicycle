class FixBikeTableForeignKey < ActiveRecord::Migration
  def change
    remove_column :bikes, :category
    add_column :bikes, :category_id, :integer
  end
end
