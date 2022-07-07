class ChangeColumnMenuRolesAccess < ActiveRecord::Migration[7.0]
  def change
    rename_column :menu_roles_access, :menu_actions, :actions
  end
end
