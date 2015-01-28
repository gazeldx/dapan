class HomeController < ApplicationController
  include Trading
  
  def index
    @votes = Vote.includes(:user).where(target_date: get_target_date_all_ok)
    @advance_count, @decline_count, @flat_count = 0, 0, 0
    @votes.where(upshot: ADVANCE).each { |vote| @advance_count += vote.user.all_kill > 0 ? vote.user.all_kill + 1 : 1 }
    @votes.where(upshot: DECLINE).each { |vote| @decline_count += vote.user.all_kill > 0 ? vote.user.all_kill + 1 : 1 }
    @votes.where(upshot: FLAT).each { |vote| @flat_count += vote.user.all_kill > 0 ? vote.user.all_kill + 1 : 1 }
    
    @aces = User.where('all_kill > 0').order(all_kill: :desc).limit(10)

    @vote = @user.try(:current_vote)
    
    if mobile?
      # render 'mobile/home/index', :layout => 'mobile/portal'
      render 'mobile/home/index'
    end

    puts "hhhh0000---------------"
  end

end