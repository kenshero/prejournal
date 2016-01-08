class Article < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Articles::Searchable
  include Articles::Mapping

  belongs_to :issue

  before_create :set_id_article

  def set_id_article
    last_id_article = Article.maximum(:id)
    puts last_id_article
    puts self.id = last_id_article.succ
  end

end
