class Journal < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Journals::Searchable
  include Journals::Mapping

  has_many :issues, dependent: :destroy
end
