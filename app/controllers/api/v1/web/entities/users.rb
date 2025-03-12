class Api::V1::Admin::Entities::Users < Grape::Entity
  expose :id
  expose :email
end
