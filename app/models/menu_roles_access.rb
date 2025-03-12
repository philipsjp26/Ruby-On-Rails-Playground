class MenuRolesAccess < ApplicationRecord
  self.table_name = "menu_roles_access"
  belongs_to :user
  belongs_to :menu, class_name: "Menu"
end
