module ApplicationHelper

  def title(_title)
    content_for :title do
      _title
    end
  end

  def error_msg(mo)
    if mo.errors.any?
      full_msg=""
      mo.errors.full_messages.each do |msg|
        full_msg=full_msg+"<li>"+msg+"</li>"
      end
      #<h2>"+pluralize(mo.errors.count, t(:num_error))+t(:op_error)+"</h2>pluralize is useless in Chinese
      raw "<div id=\"error_explanation\">
      <h2>"+mo.errors.count.to_s+t(:num_error)+t(:op_error)+"</h2>
      <ul>"+full_msg+"</ul></div>"
    end
  end

  def notice_info
    if flash[:notice]
      content_tag(:div, flash[:notice], id: 'notice')
    end
  end

  def error_info
  	if flash[:error]
      content_tag(:div, flash[:error], id: 'error')
    end
  end

end
