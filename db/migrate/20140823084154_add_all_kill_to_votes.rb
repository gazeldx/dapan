class AddAllKillToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :all_kill, :integer
  end
end
