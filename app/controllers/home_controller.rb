class HomeController < ApplicationController
  include Trading
  
  def index
    votes = Vote.where(target_date: get_target_date_all_ok)
    @advance_count = votes.where(upshot: ADVANCE).count
    @decline_count = votes.where(upshot: DECLINE).count
    @flat_count = votes.where(upshot: FLAT).count
    # return @advance_count, @decline_count, @flat_count
    
    @aces = User.where('all_kill > 0').order(all_kill: :desc).limit(7)
  end
  
end