class Index < ActiveRecord::Base
  
  include Trading
  extend Trading
  
  validates :current_date, uniqueness: true
  validates_numericality_of :closing_price, :opening_price
  validates_numericality_of :advance, only_integer: true, allow_nil: true
  validates_numericality_of :decline, only_integer: true, allow_nil: true

  def self.auto_generate
    puts "hello baby auto Time is #{Time.now} "
    Rails.logger.warn "auto_generate and Time is #{Time.now} "
    if trading_day?(Date.today)
      create_an_index
      update_users_votes
    end
  end
  
  def self.create_an_index
    source = Net::HTTP.get('hq.sinajs.cn', "/list=sh000001")
    m = source.split(',')
    puts "source is #{source}"
    index = Index.create!(opening_price: m[1], closing_price: m[3], current_date: Date.parse(m[m.size - 3]))
    index.set_upshot
    index.save!
  end
  
  def self.update_users_votes
    index = Index.last
    votes = Vote.where(target_date: index.current_date)
    
    clear_user_all_kill_not_vote_today(votes)
    
    votes.each do |vote|
      correct = (vote.upshot == index.upshot)
      user = vote.user
      all_kill = (correct ? user.all_kill + 1 : 0)
      puts "all_kill for user_id = #{user.id} is #{all_kill} "
      
      # calc_score_change
      
      vote.update_attributes(correct: correct, all_kill: all_kill, score: 0)
      user.update_attributes(all_kill: all_kill, score: 0)
    end if index.upshot.present?
  end
  
  def self.clear_user_all_kill_not_vote_today(todays_votes)
    users_ids = User.where('all_kill > 0').pluck(:id)
    (users_ids - todays_votes.map(&:user_id)).each do |user_id|
      User.find(user_id).update_attribute(:all_kill, 0)
    end
  end

  def ad
    if yesterday_closing_price.nil?
      closing_price_nil_error
    else
      if range > 0 
        "#{AD[:advance]}#{(range*100).round(2)}%"
      else
        "#{AD[:decline]}#{(range*100).abs.round(2)}%"
      end
    end
  end
  
  def set_upshot
    if yesterday_closing_price.nil?
      closing_price_nil_error
    else
      if range > FLAT_MAX
        self.upshot = ADVANCE
      elsif range < -FLAT_MAX.abs
        self.upshot = DECLINE
      else
        self.upshot = FLAT
      end
    end
  end
  
  def yesterday_closing_price
    Index.find_by_current_date(previous_trading_day(self.current_date)).try(:closing_price)
  end
  
  def range
    (closing_price - yesterday_closing_price) / yesterday_closing_price.to_f
  end
  
  private
    def closing_price_nil_error
      logger.error "Warn: #{self.current_date} 's previous trading day's closing price is nil!"
    end
end
