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

  validates :article_name, :presence => true
  # after_update  :map_role_author
  # after_initialize :filter_author_names
  # after_update :filter_author_names
  # accepts_nested_attributes_for :article_authors, 
  #                               reject_if: lambda { |l| l[:authortype].blank?  }, 
  #                               allow_destroy: true
  def cut_whitespace
    search_keywords = keywords
    search_keywords.delete_if {|keyword| keyword == "" }

    search_authors = author_name
    search_authors.delete_if {|author| author == "" }
  end

  # def map_role_author
  #   puts author_ids.inspect
  #   author_ids.each do |id_author|
  #     author_article = ArticleAuthor.find_by(author_id: id_author ,article_id: self.id)
  #     puts author_article.inspect
  #   end
  #   er
  # end

  # def filter_author_names
  #   @authors_index = []
  #   self.authors.each {|author| @authors_index << author.author_name}
  #   puts "#{self} eieiza"
  # end

end
