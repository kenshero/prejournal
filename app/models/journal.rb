class Journal < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include Journals::Searchable
  include Journals::Mapping

  has_many :issues, dependent: :destroy

  before_create :set_id_journal

  def set_id_journal
    last_id_journal = Journal.maximum(:id)
    puts last_id_journal
    puts self.id = last_id_journal.succ
  end

end
