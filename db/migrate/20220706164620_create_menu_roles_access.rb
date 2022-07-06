class CreateMenuRolesAccess < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_roles_access do |t|
      t.belongs_to :menu
      t.integer :users_id
      t.json :menu_actions
      t.timestamps
    end
  end
end
