class Vote < ActiveRecord::Base
  
  belongs_to :user
  
  validates :target_date, presence: true
  validates_uniqueness_of :user_id, scope: :target_date
  validates_inclusion_of :upshot, in: 1..3 

  def decision
    ADF[self.upshot] 
  end
  
  def index
    Index.find_by_current_date(self.target_date)
  end
end
