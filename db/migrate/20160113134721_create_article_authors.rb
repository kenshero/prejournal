class CreateArticleAuthors < ActiveRecord::Migration
  def change
    create_table :article_authors do |t|
      t.string :authortype
      t.references :author, index: true, foreign_key: true
      t.references :article, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
