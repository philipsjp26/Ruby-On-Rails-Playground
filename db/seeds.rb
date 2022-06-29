# frozen_string_literal: true

if Role.first.nil?
  roles = [{ name: "super_admin" }, { name: "admin" }, { name: "user" }]
  Role.insert_all(roles)
end

Doorkeeper::Application.find_or_create_by! name: "playground", redirect_uri: "https://localhost:3000"
