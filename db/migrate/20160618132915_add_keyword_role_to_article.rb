class AddKeywordRoleToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :keywords_role, :string , array: true, default: []
  end
end
