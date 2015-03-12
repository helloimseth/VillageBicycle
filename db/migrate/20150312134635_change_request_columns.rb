class ChangeRequestColumns < ActiveRecord::Migration
  def change
    rename_column :requests, :start_time, :start
    rename_column :requests, :end_time, :end
    remove_column :requests, :start_date
    remove_column :requests, :end_date
  end
end
