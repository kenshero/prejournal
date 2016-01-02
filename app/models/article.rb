class Article < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Articles::Searchable
  include Articles::Mapping

  belongs_to :issue
end
