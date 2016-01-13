class RenameJournalNameEngFromJournal < ActiveRecord::Migration
  def change
    rename_column :journals, :journal_name_eng, :journal_file_path
  end
end
