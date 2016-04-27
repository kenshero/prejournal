class Author < ActiveRecord::Base
  has_many  :article_authors, dependent: :destroy
  has_many  :articles, through: :article_authors

  validates :author_name, :presence => true
  
end
