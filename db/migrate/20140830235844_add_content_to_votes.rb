class AddContentToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :content, :string
  end
end
