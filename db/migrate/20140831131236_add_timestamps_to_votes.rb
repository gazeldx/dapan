class AddTimestampsToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :created_at, :datetime
    add_column :votes, :updated_at, :datetime
  end
end
