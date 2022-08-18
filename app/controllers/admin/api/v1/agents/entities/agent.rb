class Admin::Api::V1::Agents::Entities::Agent < Grape::Entity
  expose :id
  expose :privy_id
  expose :name
  expose :roles, using: Admin::Api::V1::Agents::Entities::Role
  expose :enable, as: :enabled
end
