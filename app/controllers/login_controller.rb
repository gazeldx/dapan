class LoginController < ApplicationController

  def show  	
  end

  def login
    @user = User.find_by_username(params[:username])
    if @user.nil?
      flash[:error] = t'user.not_exist'
      render :show
    else
      proc_session
      flash[:notice] = t('success', w: t('login'))
      redirect_to root_path
    end
  end

  def logout
    session[:id], session[:username], session[:nick_name] = nil, nil, nil
    flash[:notice] = t('success', w: t('logout'))
    redirect_to root_path
  end

end