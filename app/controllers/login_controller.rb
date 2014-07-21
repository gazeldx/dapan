class LoginController < ApplicationController

  def show  	
  end

  def login
    @user = User.find_by_mobile(params[:mobile])
    if @user.nil?
      flash[:error] = t'user.not_exist'
      render :show
    else
      proc_session
      #flash[:notice] = t('succ', :w => t('login'))
      redirect_to root_path
    end
  end

  def logout
    session[:id], session[:name], session[:domain] = nil, nil, nil
    flash[:notice] = t('succ', :w => t('logout'))
    redirect_to root_path
  end

end