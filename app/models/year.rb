class Year < ActiveRecord::Base
  belongs_to :journal
  has_many :issues, dependent: :destroy

  validates :journal_year, :presence => true,
                      :length => {:within => 4..4},
                      :numericality => true
end
