module Trading
  
  def previous_trading_day(date)
    date = date - 1
    until trading_day?(date)
      if HOLIDAYS.include?(date.to_s)
        date = date - 1
        next
      end
      
      if date.saturday?
        date = date - 1
      elsif date.sunday?
        date = date - 2
      end
    end
    date
  end
  
  def next_trading_day(date)
    date = date + 1
    until trading_day?(date)
      if HOLIDAYS.include?(date.to_s)
        date = date + 1
        next
      end
      
      if date.saturday?
        date = date + 2
      elsif date.sunday?
        date = date + 1
      end
    end
    date
  end
  
  def trading_day?(date)
    !(HOLIDAYS.include?(date.to_s) or (date.sunday? or date.saturday?))
  end
  
  def trading_time?
    now = Time.now
    if trading_day?(now)
      now.between?(trade_time_start(now), trade_time_stop(now))
    else
      false
    end
  end
  
  def get_target_date
    today = Date.today
    if trading_day?(today)
      now = Time.now
      if now < trade_time_start(now)
        today
      elsif now > trade_time_stop(now)
        next_trading_day(today)
      else
        nil
      end
    else
      next_trading_day(today)
    end
  end
  
  def get_target_date_all_ok
    get_target_date.nil? ? Date.today: get_target_date
  end

  def trading_day_before_open?
    now = Time.now
    trading_day?(now) and now < trade_time_start(now)
  end
  
  def trade_time_start(now)
    Time.new(now.year, now.month, now.day, 9, 25, 0, "+08:00")
  end
  
  def trade_time_stop(now)
    Time.new(now.year, now.month, now.day, 15, 0, 0, "+08:00")
  end
  
  def day_name_in_week(date)
    ['周日', '周一', '周二', '周三', '周四', '周五', '周六'][date.wday]
  end
end