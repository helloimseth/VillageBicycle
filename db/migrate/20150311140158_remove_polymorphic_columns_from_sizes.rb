class RemovePolymorphicColumnsFromSizes < ActiveRecord::Migration
  def change
    remove_column :sizes, :sizable_id
    remove_column :sizes, :sizable_type
  end
end
