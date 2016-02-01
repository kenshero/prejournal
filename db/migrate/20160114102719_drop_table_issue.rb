class DropTableIssue < ActiveRecord::Migration
  def change
    drop_table :issues, force: :cascade
  end
end
