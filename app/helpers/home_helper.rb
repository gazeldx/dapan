module HomeHelper
  
  include Trading
  
  def vote_box
    target_date = get_target_date
    tip = "对#{date_and_week_name(target_date)}的大盘，你的观点是：<br>"
    if logged?
      if voted?(target_date)
        result = "你今天的预测是#{@user.current_vote.decision}。"
        if trading_day_before_open?
          "#{result}等今天收盘后再来预测吧！"
        else
          "#{result}等下一交易日收盘后再来预测吧！"
        end
      elsif trading_time?
        '这是交易时间，请等收盘后再来预测！'
      else
        raw "#{tip}#{content_tag(:p, vote_button(ADVANCE) + ' ' + vote_button(DECLINE) + ' ' + vote_button(FLAT))}"
      end
    else
      raw "#{tip}#{content_tag(:p, vote_button_for_not_login(ADVANCE) + ' ' + vote_button_for_not_login(DECLINE) + ' ' + vote_button_for_not_login(FLAT))}"
    end
  end

  def date_and_week_name(date)
    "#{date}(#{day_name_in_week(date)})"
  end
  
  private
    def vote_button(adf)
      #TODO Use Chinese blank to take the place or , :style => 'margin-right:10;'
      color = ['success', 'danger', 'warning']
      link_to(ADF[adf - 1], "/vote_#{adf.to_s}", :class => "btn btn-lg btn-#{color[adf - 1]}", :role => 'button')
    end
    
    def vote_button_for_not_login(adf)
      color = ['success', 'danger', 'warning']
      link_to(ADF[adf - 1], new_user_path, :class => "btn btn-lg btn-#{color[adf - 1]}", :role => 'button')  
    end  
end