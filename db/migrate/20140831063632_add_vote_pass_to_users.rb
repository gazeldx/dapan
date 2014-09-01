class AddVotePassToUsers < ActiveRecord::Migration
  def change
    add_column :users, :passwd, :string
  end
end
