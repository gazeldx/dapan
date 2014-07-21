class User < ActiveRecord::Base
  validates :mobile, uniqueness: true, length: { is: 11 }
end
