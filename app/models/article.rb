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

  # after_initialize :filter_author_names
  # after_update :filter_author_names
  # accepts_nested_attributes_for :article_authors, 
  #                               reject_if: lambda { |l| l[:authortype].blank?  }, 
  #                               allow_destroy: true
  def cut_whitespace
    search_keywords = keywords
    search_keywords.delete_if {|keyword| keyword == "" }

    # search_authors = author_names
    # search_authors.delete_if {|author| author == "" }
  end

  # def filter_author_names
  #   @authors_index = []
  #   self.authors.each {|author| @authors_index << author.author_name}
  #   puts "#{self} eieiza"
  # end

end
