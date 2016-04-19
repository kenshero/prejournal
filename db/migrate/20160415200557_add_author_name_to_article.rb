class AddAuthorNameToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :author_name, :string , array: true, default: []
  end
end
