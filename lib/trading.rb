module Trading
  
  #TODO holiday should be rejected
  def previous_trading_day(date)
    if date.monday?
      date - 3
    elsif date.sunday?
      date - 2
    else
      date - 1
    end
  end
  
  #TODO holiday should be rejected
  def next_trading_day(date)
    if date.friday?
      date + 3
    elsif date.saturday?
      date + 2
    else
      date + 1
    end
  end
  
  def day_name_in_week(date)
    ['周日', '周一', '周二', '周三', '周四', '周五', '周六'][date.wday]
  end
end