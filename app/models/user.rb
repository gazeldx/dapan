class User < ActiveRecord::Base
  validates_length_of :username, within: 6..20
  validates_uniqueness_of :username
  validates_length_of :mobile, is: 11, allow_blank: true
  validates_uniqueness_of :mobile, allow_blank: true, allow_nil: true
  
  def nick_name
    self.nickname.presence || DEFAULT_NICKNAME
  end
end
