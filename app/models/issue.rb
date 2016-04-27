class Issue < ActiveRecord::Base
  belongs_to :year

  validates :number, :presence => true

  has_many :articles, dependent: :destroy
end
