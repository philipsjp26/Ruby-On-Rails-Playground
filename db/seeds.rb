# frozen_string_literal: true

Role.find_or_create_by! name: "super_admin"
Role.find_or_create_by! name: "admin"
Role.find_or_create_by! name: "user"

Doorkeeper::Application.find_or_create_by! name: "API_RBAC", redirect_uri: "https://localhost:3000"