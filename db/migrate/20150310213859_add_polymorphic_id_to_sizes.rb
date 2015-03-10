class AddPolymorphicIdToSizes < ActiveRecord::Migration
  def change
    add_column :sizes, :sizable_id, :integer
    add_column :sizes, :sizable_type, :string
  end
end
