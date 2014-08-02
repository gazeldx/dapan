module HomeHelper
  def vote_box
    if logged?
      if voted_today?
        raw "你今天已经投过票了。等收盘后再来预测吧。"
      elsif trade_time?
        raw "这是交易时间，请等收盘后再来预测！"
      else
        raw "请提交观点：<br>#{link_to '看多', "/vote_#{ADVANCE}"}&nbsp;&nbsp;#{link_to '看空', "/vote_#{DECLINE}"}&nbsp;&nbsp;#{link_to '看平', "/vote_#{FLAT}"}"
      end
    else
      raw "请提交观点：<br>#{link_to '看多', new_user_path}&nbsp;&nbsp;#{link_to '看空', new_user_path}&nbsp;&nbsp;#{link_to '看平', new_user_path}"
    end
  end
end