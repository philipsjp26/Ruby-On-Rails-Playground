class CreateAgents < ActiveRecord::Migration[7.0]
  def change
    create_table :agents do |t|
      t.string :privy_id
      t.string :access_token
      t.string :name
      t.boolean :enable, default: true

      t.timestamps
    end
    add_index :agents, :privy_id
    add_index :agents, :access_token
  end
end
