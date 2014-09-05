class LoginController < ApplicationController

  def show
    redirect_to root_path if logged?
  end

  def login
    @user = User.find_by_username(params[:username])
    if @user.nil?
      flash[:error] = t'user.not_exist'
      render :show
    else
      if @user.passwd.blank?
        login_process
      else
        if params[:passwd].blank?
          flash[:username] = params[:username]
          redirect_to login2_path
        else
          if @user.passwd == Digest::SHA1.hexdigest(params[:passwd])
            login_process
          else
            flash[:error] = t'login.password_wrong'
            redirect_to login2_path
          end
        end
      end
    end
  end

  def logout
    session[:id], session[:username], session[:nick_name] = nil, nil, nil
    flash[:notice] = t('success', w: t('logout'))
    redirect_to root_path
  end
  
  private
   def login_process
     proc_session
     Login.create!(ip: request.remote_ip, user_id: @user.id)
     flash[:notice] = t('success', w: t('_login'))
     redirect_to root_path
   end 

end