class Index < ActiveRecord::Base
  
  include Trading
  
  validates :current_date, uniqueness: true#TODO should not be holiday and sunday.
  validates_numericality_of :closing_price, :opening_price
  validates_numericality_of :advance, only_integer: true, allow_nil: true
  validates_numericality_of :decline, only_integer: true, allow_nil: true
  # validates_inclusion_of :upshot, in: 0..3

  before_save :set_upshot

  def self.auto_generate
    source = Net::HTTP.get('hq.sinajs.cn', "/list=sh000001")
    m = source.split(',')
    puts "source is #{source}"
    Index.create!(opening_price: m[1], closing_price: m[3], current_date: Date.parse(m[m.size - 3]))
  end

  def set_upshot
    yesterday_closing_price = Index.find_by_current_date(previous_trading_day(self.current_date)).closing_price
    range = (closing_price - yesterday_closing_price) / yesterday_closing_price
    if range > FLAT_MAX
      self.upshot = ADVANCE
    elsif range < -FLAT_MAX
      self.upshot = DECLINE
    else
      self.upshot = FLAT
    end
    # self.upshot = FLAT
  end
  
end
