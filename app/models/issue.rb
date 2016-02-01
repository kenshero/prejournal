class Issue < ActiveRecord::Base
  belongs_to :year
  has_many :articles, dependent: :destroy
end
