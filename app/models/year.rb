class Year < ActiveRecord::Base
  belongs_to :journal
  has_many :issues, dependent: :destroy

  validates :journal_year, :presence => true,
                      :length => {:within => 4..4},
                      :numericality => { :less_than_or_equal_to => Date.current.year + 543 }
end
