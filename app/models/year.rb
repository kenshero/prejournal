class Year < ActiveRecord::Base
  belongs_to :journal
  has_many :issues, dependent: :destroy
end
