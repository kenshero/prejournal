class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :article_name_th
      t.string :article_name_eng
      t.references :issue, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
