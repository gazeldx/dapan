class HomeController < ApplicationController
  include Trading
  
  def index
    @votes = Vote.where(target_date: get_target_date_all_ok)
    @advance_count = @votes.where(upshot: ADVANCE).count
    @decline_count = @votes.where(upshot: DECLINE).count
    @flat_count = @votes.where(upshot: FLAT).count
    
    @players = User.where('all_kill > 0').order(all_kill: :desc)
    
    good_players
    
    @aces = @players.limit(7)
    
    @vote = @user.try(:current_vote)
  end
  
  private
    def good_players
      @advance_count_h, @decline_count_h, @flat_count_h  = 0, 0, 0
      (@players.map(&:id) & @votes.map(&:user_id)).each do |user_id|
        upshot = User.find(user_id).current_vote.upshot
        if upshot == DECLINE
          @decline_count_h += 1
        elsif upshot == ADVANCE
          @advance_count_h += 1
        elsif upshot == FLAT
          @flat_count_h += 1
        end
      end
    end
    
end