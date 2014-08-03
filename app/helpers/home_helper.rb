module HomeHelper
  
  include Trading
  
  def vote_box
    target_day = next_trading_day(Date.today)
    tip = "对#{target_day}(#{day_name_in_week(target_day)})的大盘，你的观点是：<br>"
    if logged?
      next_target_day = next_trading_day(target_day)
      if voted_today?
        raw "你今天已经投过票了。等收盘后再来预测#{next_target_day}(#{day_name_in_week(next_target_day)})走势吧。"
      elsif trading_time?
        raw "这是交易时间，请等收盘后再来预测！"
      else
        raw "#{tip}#{link_to '看多', "/vote_#{ADVANCE}"}&nbsp;&nbsp;#{link_to '看空', "/vote_#{DECLINE}"}&nbsp;&nbsp;#{link_to '看平', "/vote_#{FLAT}"}"
      end
    else
      raw "#{tip}#{link_to '看多', new_user_path}&nbsp;&nbsp;#{link_to '看空', new_user_path}&nbsp;&nbsp;#{link_to '看平', new_user_path}"
    end
  end

end