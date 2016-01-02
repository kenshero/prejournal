class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :journal_name_th
      t.string :journal_name_eng

      t.timestamps null: false
    end
  end
end
