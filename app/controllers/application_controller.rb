class ApplicationController < ActionController::Base
  
  helper_method :voted_today?
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  def proc_session
    session[:id] = @user.id
    session[:mobile] = @user.mobile
    session[:nick_name] = @user.nick_name
  end
  
  def voted_today?
    @vote = Vote.find_by_user_id_and_target_date(session[:id], Date.today)
  end
  
end
