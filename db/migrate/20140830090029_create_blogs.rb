class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.references :user, index: true
      t.string :content
      t.date :target_date
    end
  end
end
