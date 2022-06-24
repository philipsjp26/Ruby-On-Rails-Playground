class Api::V1::Oauth::Entities::Oauth < Grape::Entity
  expose :token
  expose :refresh_token
  expose :expires_in
end
