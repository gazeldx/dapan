class Admin::VotesController < Admin::BaseController

  def update_user_vote
  	today = Date.today
  	if trading_day?(today)
  	  index = Index.find_by_current_date(today)
  	  if index
        votes = Vote.where(target_date: today)
        votes.each do |vote|
          vote.update_attribute(:correct, true) if vote.upshot == index.upshot
        end
  	  end
  	end
  end
  
end