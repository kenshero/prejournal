class RenameJournalNameThToJournalNameFromJournal < ActiveRecord::Migration
  def change
    rename_column :journals, :journal_name_th, :journal_name
  end
end
