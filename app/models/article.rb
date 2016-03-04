class Article < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Articles::Searchable
  include Articles::Mapping

  belongs_to :issue
  has_many :article_authors, dependent: :destroy
  has_many :authors, through: :article_authors
  before_create :cut_whitespace
  before_update :cut_whitespace

  def cut_whitespace
    search_keywords = keywords
    search_keywords.delete_if {|keyword| keyword == "" }
  end
end
