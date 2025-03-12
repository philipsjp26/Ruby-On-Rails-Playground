class User < ApplicationRecord
  has_secure_password
  has_one :wallet, foreign_key: "user_id"
end
