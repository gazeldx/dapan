module HomeHelper
  
  include Trading
  
  def vote_box
    if trading_time?
      '这是交易时间，请等收盘后再来！'
    else
      target_date = get_target_date
      tip = ''
      if logged?
        if voted?(target_date)
          result = "您已投<span class='text-#{COLOR[@user.current_vote.upshot]}'>#{@user.current_vote.decision}，</span>"
          raw trading_day_before_open? ? "#{result}欢迎你今天收盘后再来！" : "#{result}欢迎下一交易日收盘后再来！"
        else
          raw "#{tip}#{content_tag(:p, vote_button(ADVANCE) + ' ' + vote_button(FLAT) + ' ' + vote_button(DECLINE))}"
        end
      else
        raw "#{tip}#{content_tag(:p, vote_button_for_not_login(ADVANCE) + ' ' + vote_button_for_not_login(FLAT) + ' ' + vote_button_for_not_login(DECLINE))}"
      end
    end
  end

  def date_and_week_name(date)
    "#{date_name(date)}#{day_name_in_week(date)}"
  end
  
  private
    def vote_button(adf)
      link_to(ADF[adf], "/vote_#{adf.to_s}", :class => "btn btn-lg btn-#{COLOR[adf]}", :role => 'button', title: '0.35')
    end
    
    def vote_button_for_not_login(adf)
      link_to(ADF[adf], new_user_path, :class => "btn btn-lg btn-#{COLOR[adf]}", :role => 'button', title: '0.35', style: 'padding: 8px 13px;')  
    end  
end