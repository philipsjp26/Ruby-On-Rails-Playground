# frozen_string_literal: true

if User.first.nil?
  user = User.create(email: "testing@gmail.com", password: "admin123", password_confirmation: "admin123")
  Wallet.create(user: user, balance: 1000000, owner_type: "user")
end
