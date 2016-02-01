class ModifileArticle < ActiveRecord::Migration
  def change
    rename_column :articles, :article_name_th, :article_name
    
    remove_column :articles, :article_name_eng, :string

    add_column :articles, :pdf_path, :string
    add_column :articles, :keywords, :string , array: true, default: []
  end
end
