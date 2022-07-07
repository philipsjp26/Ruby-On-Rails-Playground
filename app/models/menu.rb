class Menu < ApplicationRecord
  self.table_name = "menus"
  Actions = { list: false, create: false, edit: false, delete: false }
  has_many :users, foreign_key: "menu_id"
  has_many :menu_roles_access, foreign_key: "menu_id"
end
