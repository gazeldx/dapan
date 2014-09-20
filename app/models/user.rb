class User < ActiveRecord::Base
  include Trading
  
  has_many :votes
  has_many :blogs
  has_many :logins
  
  validates_length_of :username, within: 6..22
  validates_uniqueness_of :username
  validates_uniqueness_of :nickname, allow_blank: true, allow_nil: true
  validates_length_of :nickname, in: 2..12, allow_blank: true
  validates_length_of :mobile, is: 11, allow_blank: true
  validates_uniqueness_of :mobile, allow_blank: true, allow_nil: true
  
  def current_vote
    logger.info "query current_vote"
    Vote.find_by_user_id_and_target_date(self.id, get_target_date_all_ok)
  end
    
  def nick_name
    self.nickname.presence || DEFAULT_NICKNAME
  end
end
