class ApplicationController < ActionController::Base
  
  before_filter :current_user
  
  helper_method :voted?, :logged?
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  

  def proc_session
    session[:id] = @user.id
    session[:username] = @user.username
    session[:nick_name] = @user.nick_name
  end
  
  def current_user
    @user = User.find(session[:id]) unless session[:id].nil? 
  end
  
  def admin?
    session[:username] == 'admin4'
  end
  
  def admin
    redirect_to root_path unless admin?
  end
  
  def voted?(date)
    @vote = Vote.find_by_user_id_and_target_date(session[:id], date)
  end

  def logged?
    session[:id]
  end
  
end
