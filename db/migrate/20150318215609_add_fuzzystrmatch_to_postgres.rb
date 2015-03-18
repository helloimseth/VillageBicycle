class AddFuzzystrmatchToPostgres < ActiveRecord::Migration
  def change
    enable_extension "fuzzystrmatch"
  end
end
