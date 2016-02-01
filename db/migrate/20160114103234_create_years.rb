class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
      t.string :journal_year
      t.references :journal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
