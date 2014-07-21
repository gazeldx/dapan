class Index < ActiveRecord::Base
  validates :current_date, uniqueness: true
  validates_numericality_of :closing_price, :opening_price
  validates_numericality_of :advance, only_integer: true
  validates_numericality_of :decline, only_integer: true
  # validates_inclusion_of :upshot, in: 0..3

  before_save :set_upshot

  def set_upshot
    puts "calc_upshot now........"
    puts self.inspect
    self.upshot = 1
    yesterday_closing_price = Index.find_by_current_date(self.current_date - 1). This may be nil closing_price
    amplitude = (closing_price - yesterday_closing_price) / yesterday_closing_price
    if amplitude > FLAT_MAX
      self.upshot = ADVANCE
    elsif amplitude < -FLAT_MAX
      self.upshot = DECLINE
    else
      self.upshot = FLAT
    end
    puts "xxxxxxxxxxxxx--------------------------"+ upshot.inspect
  end

end
