class HomeController < ApplicationController
  
  def index
    votes = Vote.where(target_date: Date.today)
    @advance_count = votes.where(upshot: ADVANCE).count
    @decline_count = votes.where(upshot: DECLINE).count
    @flat_count = votes.where(upshot: FLAT).count
    return @advance_count, @decline_count, @flat_count
  end
  
end