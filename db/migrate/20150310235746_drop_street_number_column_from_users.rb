class DropStreetNumberColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :street_number
  end
end
