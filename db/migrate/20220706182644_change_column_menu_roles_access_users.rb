class ChangeColumnMenuRolesAccessUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :menu_roles_access, :users_id, :user_id
  end
end
