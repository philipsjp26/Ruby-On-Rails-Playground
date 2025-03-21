class Api::V1::Main < Grape::API
  include Config

  prefix "api"
  version "v1", using: :path
  
  mount Api::V1::Admin::Routes
  mount Api::V1::Oauth::Routes
end
