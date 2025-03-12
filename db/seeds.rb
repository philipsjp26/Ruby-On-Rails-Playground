# frozen_string_literal: true

if Menu.first.nil?
  menus = [{ name: "master_data" }, { name: "users" }, { name: "activity_logs" }]
  Menu.insert_all(menus)
end
if Role.first.nil?
  roles = [{ name: "super_admin" }, { name: "admin" }, { name: "user" }]
  Role.insert_all(roles)
elsif User.first.nil?
  user = User.new
  user.username = "philipsjp"
  user.email = "philipsjp99@gmail.com"
  user.fullname = "philips jose patric"
  user.password = "12345"
  user.registered_at = Time.now
  user.roles << Role.find_by(name: "super_admin")  
  user.try(:save)
end


Doorkeeper::Application.find_or_create_by! name: "playground", redirect_uri: "https://localhost:3000"
