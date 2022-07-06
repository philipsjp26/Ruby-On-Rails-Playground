class CreateActivityLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_logs do |t|
      t.references :users, index: true, foreign_key: true
      t.datetime :signin_at, null: true
      t.datetime :signout_at, null: true
      t.string :description
      t.timestamps
    end
  end
end
