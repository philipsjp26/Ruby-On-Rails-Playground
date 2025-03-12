class User < ApplicationRecord
  has_many :menu_roles_access, foreign_key: "user_id"
  has_and_belongs_to_many :menus, join_table: :menu_roles_access, foreign_key: "user_id"
  has_and_belongs_to_many :roles, join_table: :roles_users, dependent: :destroy

  alias_attribute :menu_actions, :menu_roles_access

  scope :created_between, lambda { |start_date, end_date| where("users.created_at BETWEEN ? AND ?", start_date.beginning_of_day, end_date.end_of_day) }

  def self.list(params)
    data = self.joins(:roles).select(:id, :username, :fullname, :registered_at, :created_at, "roles.id AS role_id", "roles.name AS role_name")
    data = data.where("username ILIKE '%#{params.q}%' OR fullname ILIKE '%#{params.q}%'") if params.q.present?
    data = data.created_between(params.start_date, params.end_date) if params.start_date.present?
    data
  end
end
