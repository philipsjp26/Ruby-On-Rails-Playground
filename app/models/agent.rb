class Agent < ApplicationRecord  
  has_and_belongs_to_many :roles, join_table: :agent_roles, dependent: :destroy
end
