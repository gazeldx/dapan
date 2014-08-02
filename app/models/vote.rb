class Vote < ActiveRecord::Base
  validates_inclusion_of :upshot, in: 1..3
end
