class CreateIndex < ActiveRecord::Migration
  def change
    create_table :indices do |t|
      t.date :current_date
      t.float :closing_price
      t.float :opening_price
      t.integer :advance
      t.integer :decline
      t.integer :upshot
    end
  end
end
