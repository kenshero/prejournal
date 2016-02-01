class DropJournalPath < ActiveRecord::Migration
  def change
    remove_column :journals, :journal_file_path, :string
  end
end
