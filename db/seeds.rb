# frozen_string_literal: true
Role.find_or_create_by! code: "super_admin", name: "Super Admin"
if Agent.first.nil?
  Agent.find_or_create_by!(privy_id: "ph7748", enable: true)
end
ActiveRecord::Base.connection.execute("INSERT INTO agent_roles (agent_id, role_id) VALUES (1,1)")
Configuration.find_or_create_by! key: "auth_client_id"
Configuration.find_or_create_by! key: "auth_client_secret"
Configuration.find_or_create_by! key: "dci_auth_service"
