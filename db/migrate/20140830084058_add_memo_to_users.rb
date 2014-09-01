class AddMemoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :memo, :string
  end
end
