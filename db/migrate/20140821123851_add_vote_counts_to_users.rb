class AddVoteCountsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :all_kill, :integer
    add_column :users, :month_correct, :integer
  end
end
