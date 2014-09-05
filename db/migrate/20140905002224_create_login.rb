class CreateLogin < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.references :user, index: true
      t.string :ip
      t.timestamps
    end
  end
end
