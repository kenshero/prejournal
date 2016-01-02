class Issue < ActiveRecord::Base
  belongs_to :journal
  has_many :articles, dependent: :destroy
end
