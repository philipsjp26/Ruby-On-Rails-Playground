class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.string :code
      t.string :name

      t.timestamps
    end

    create_table(:agent_roles, id: false) do |t|
      t.references :agent
      t.references :role
    end
  end
end
