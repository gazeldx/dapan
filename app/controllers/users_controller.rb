class UsersController < ApplicationController
  before_filter :admin, only: [:index, :destroy]
  before_action :set_user, only: [:show, :destroy]

  def index
    @users = User.all
  end

  def show
    @votes = @user.votes.order('id DESC')
    @all_count = @user.votes.count
    @correct_count = @user.votes.where(upshot: true).count
    @correct_rate = @all_count == 0 ? 0 : ((@correct_count / @all_count.to_f)*100).round(1)
    @max_all_kill = @user.votes.maximum('all_kill')
    render layout: 'user'
  end

  def new
    if logged?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def profile
    @_user = User.find(session[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      proc_session
      redirect_to root_path, notice: "您好，#{@user.nick_name}。#{t('user.created_succ')}"
    else
      render :new
    end
  end

  def update
    @_user = User.find(params[:id])
    if @_user.update(user_params)
      redirect_to profile_path, notice: '您的个人资料已修改成功！'
    else
      render :profile
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :mobile, :nickname)
    end
end
