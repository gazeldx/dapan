class Index < ActiveRecord::Base
  
  include Trading
  extend Trading
  validates :current_date, uniqueness: true#TODO should not be holiday and sunday.
  validates_numericality_of :closing_price, :opening_price
  validates_numericality_of :advance, only_integer: true, allow_nil: true
  validates_numericality_of :decline, only_integer: true, allow_nil: true
  # validates_inclusion_of :upshot, in: 0..3

  # before_save :set_upshot

  def self.auto_generate
    puts "hello baby auto Time is #{Time.now} "
    Rails.logger.warn "auto_generate and Time is #{Time.now} "
    create_an_index if trading_day?(Date.today)
  end
  
  def self.create_an_index
    source = Net::HTTP.get('hq.sinajs.cn', "/list=sh000001")
    m = source.split(',')
    puts "source is #{source}"
    index = Index.create!(opening_price: m[1], closing_price: m[3], current_date: Date.parse(m[m.size - 3]))
    index.set_upshot
    index.save!
  end

  def set_upshot
    yesterday_closing_price = Index.find_by_current_date(previous_trading_day(self.current_date)).try(:closing_price)
    if yesterday_closing_price.nil?
      logger.error "Warn: #{self.current_date} 's previous trading day's closing price is nil!"
    else
      range = (closing_price - yesterday_closing_price) / yesterday_closing_price
      if range > FLAT_MAX
        self.upshot = ADVANCE
      elsif range < -FLAT_MAX
        self.upshot = DECLINE
      else
        self.upshot = FLAT
      end
    end
  end
  
end
