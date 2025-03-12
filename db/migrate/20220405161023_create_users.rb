class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, unique: true
      t.string :email, unique: true
      t.string :fullname
      t.string :password
      t.datetime :registered_at
      t.datetime :approved_at
      t.datetime :rejected_at
      t.timestamps
    end
  end
end
