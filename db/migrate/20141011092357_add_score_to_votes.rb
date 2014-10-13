class AddScoreToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :score, :float
  end
end
