class VotesController < ApplicationController
  include Trading
  
  before_filter :check_time_for_voting
  
  def do_vote
    target_date = get_target_date
    unless voted?(target_date)
      @vote = Vote.new(user_id: session[:id], target_date: target_date, upshot: params[:upshot])
      redirect_to root_path, notice: t('vote.success') if @vote.save!
    else
      redirect_to root_path, notice: t('vote.done_before')
    end
  end
  
  def check_time_for_voting
    redirect_to root_path, notice: t('It is trading time. So you cannot vote now.') if trading_time?
  end
    
end