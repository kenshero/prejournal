class Journal < ActiveRecord::Base
  validates :journal_name, :presence => true
  
  has_many :years, dependent: :destroy
end
