class AddPaperClipToUsersAndBikes < ActiveRecord::Migration
  def self.up
    add_attachment :users, :picture
    add_attachment :bikes, :picture
  end

  def self.down
    remove_attachment :users, :picture
    remove_attachment :bikes, :picture
  end
end
