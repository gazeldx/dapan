module HomeHelper
  def vote_or_reg
    if logged?
      raw "&nbsp;#{link_to '看多', new_user_path}&nbsp;&nbsp;#{link_to '看多', new_user_path}&nbsp;&nbsp;#{link_to '看多', new_user_path}"
    else
      raw "&nbsp;#{link_to '看多', new_user_path}&nbsp;&nbsp;#{link_to '看空', new_user_path}&nbsp;&nbsp;#{link_to '看平', new_user_path}"	
    end
  end
end