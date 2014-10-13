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
  
  before_create :set_user
  
  def current_vote
    Vote.find_by_user_id_and_target_date(self.id, get_target_date_all_ok)
  end
    
  def target_vote(target_date)
    Vote.find_by_user_id_and_target_date(self.id, target_date)
  end
  
  def nick_name
    self.nickname.presence || DEFAULT_NICKNAME
  end
  
  def set_user
    self.score = SCORE_INIT
    self.all_kill = 0
    self.month_correct = 0
  end
  
  def calc_score_change_base
    index = Index.last
    vote = target_vote(index.current_date)
    return 0 if vote.nil?
    
    h = {}, correct = 0
    votes = Vote.where(target_date: index.current_date)
    votes.select { |vote| vote.upshot == index.upshot }.each do |vote|
      h[vote.user.all_kill] += 1
      correct += 1
    end
    sum = 0
    h.each { |k, v| sum += v * (1.3 ** k) }
    
    correct > 0 ? (votes.size - correct).to_f / sum : 0
  end
  
end
