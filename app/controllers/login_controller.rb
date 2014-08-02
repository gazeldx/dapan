class LoginController < ApplicationController

  def show  	
  end

  def login
    @user = User.find_by_username(params[:username])
    puts @user.inspect
    if @user.nil?
      flash[:error] = t'user.not_exist'
      render :show
    else
      proc_session
      redirect_to root_path
    end
  end

  def logout
    session[:id], session[:mobile], session[:nick_name] = nil, nil, nil
    flash[:notice] = t('success', w: t('logout'))
    redirect_to root_path
  end

end