class Vote < ActiveRecord::Base
  validates :target_date, presence: true
  validates_uniqueness_of :user_id, scope: :target_date
  validates_inclusion_of :upshot, in: 1..3
end
