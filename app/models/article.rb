class Article < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Articles::Searchable
  include Articles::Mapping

  belongs_to :issue
  has_many :article_authors, dependent: :destroy
  has_many :authors, through: :article_authors
  before_create :set_id_article

  def set_id_article
    last_id_article = Article.maximum(:id)
    puts last_id_article
    puts self.id = last_id_article.succ
  end

end
