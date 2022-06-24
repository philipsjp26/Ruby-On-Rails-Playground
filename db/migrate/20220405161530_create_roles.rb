class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.string :name, index: { unique: true }
      t.string :description, null: true
      t.timestamps
    end
  end
end
