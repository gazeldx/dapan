class VotesController < ApplicationController

  def do_vote
    unless voted_today?
      @vote = Vote.new(user_id: session[:id], target_date: Date.today, upshot: params[:upshot])  	
      redirect_to @vote, notice: t('vote.success') if @vote.save!
    else
      redirect_to root_path, notice: t('vote.done_before')
    end
  end
  
  def today
    votes_today = Vote.where(target_date: Date.today)
    @advance_count = votes_today.where(upshot: ADVANCE).count
    # @advance_count = Vote.where(target_date: Date.today, upshot: ADVANCE).count
    @decline_count = votes_today.where(upshot: DECLINE).count
    @flat_count = votes_today.where(upshot: FLAT).count
    return @advance_count, @decline_count, @flat_count
  end

end