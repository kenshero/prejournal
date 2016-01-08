class Issue < ActiveRecord::Base
  belongs_to :journal
  has_many :articles, dependent: :destroy

  before_create :set_id_issue

  def set_id_issue
    last_id_issue = Issue.maximum(:id)
    puts last_id_issue
    puts self.id = last_id_issue.succ
  end
end
