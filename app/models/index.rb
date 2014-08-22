class Index < ActiveRecord::Base
  
  include Trading
  extend Trading
  
  validates :current_date, uniqueness: true
  validates_numericality_of :closing_price, :opening_price
  validates_numericality_of :advance, only_integer: true, allow_nil: true
  validates_numericality_of :decline, only_integer: true, allow_nil: true
  # validates_inclusion_of :upshot, in: 0..3

  # before_save :set_upshot

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
    
    users_ids = User.where('all_kill > 0').pluck(:id)
    (users_ids - votes.map(&:user_id)).each do |user_id|
      User.find(user_id).update_attribute(:all_kill, 0)
    end
    
    votes.each do |vote|
      result = vote.upshot == index.upshot
      vote.update_attribute(:correct, result)
      
      user = vote.user
      all_kill = (result ? user.all_kill + 1 : 0)#TODO: The user who not vote today should also be updated to 0!
      user.update_attribute(:all_kill, all_kill)
    end if index.upshot.present?
  end

  def set_upshot
    yesterday_closing_price = Index.find_by_current_date(previous_trading_day(self.current_date)).try(:closing_price)
    if yesterday_closing_price.nil?
      logger.error "Warn: #{self.current_date} 's previous trading day's closing price is nil!"
    else
      range = (closing_price - yesterday_closing_price) / yesterday_closing_price.to_f
      if range > FLAT_MAX
        self.upshot = ADVANCE
      elsif range < -FLAT_MAX.abs
        self.upshot = DECLINE
      else
        self.upshot = FLAT
      end
    end
  end
  
end
