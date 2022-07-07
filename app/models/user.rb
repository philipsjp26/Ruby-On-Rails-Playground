class User < ApplicationRecord
  has_many :menu_roles_access, foreign_key: "user_id"
  has_and_belongs_to_many :menus, join_table: :menu_roles_access, foreign_key: "user_id"
  has_and_belongs_to_many :roles, join_table: :roles_users, dependent: :destroy

  alias_attribute :menu_actions, :menu_roles_access  
end
