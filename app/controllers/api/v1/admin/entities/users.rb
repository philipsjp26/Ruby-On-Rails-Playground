class Api::V1::Admin::Entities::Users < Grape::Entity
  expose :id
  expose :username
  expose :fullname
  expose :registered_at
  expose :created_at
end
