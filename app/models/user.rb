class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :username, presence: true, uniqueness: true, length: { minimum: 5 }

  has_many :user_images, dependent: :destroy  
  has_and_belongs_to_many :roles, join_table: :roles_users, dependent: :destroy

  def validate_password!(password)
    password == BCrypt::Password.new(self.password)
  end

  def logout
    Doorkeeper::AccessToken.where(resource_owner_id: self.id).destroy_all    
  end
end
