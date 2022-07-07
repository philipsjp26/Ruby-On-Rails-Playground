class User < ApplicationRecord
<<<<<<< HEAD
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
=======
  has_many :menu_roles_access, foreign_key: "user_id"
  has_and_belongs_to_many :menus, join_table: :menu_roles_access, foreign_key: "user_id"
  has_and_belongs_to_many :roles, join_table: :roles_users, dependent: :destroy

  alias_attribute :menu_actions, :menu_roles_access  
>>>>>>> ed9f51740eecf5022e892327d3729e0261827cde
end
