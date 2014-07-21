class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def proc_session
    session[:id] = @user.id
    session[:mobile] = @user.mobile
    session[:nickname] = @user.nickname
  end
end
