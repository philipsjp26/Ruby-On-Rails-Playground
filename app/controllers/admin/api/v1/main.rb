class Admin::Api::V1::Main < Grape::API
  include Config

  prefix "api"
  version "v1", using: :path
  # Exception Handlers
  unless ENV["DEBUGGING"].eql?("true") && Rails.env.development?
    include ExceptionHandler
  end

  use Oauth::Guard::Oauth2

  helpers do
    def current_user
      current_user
    end
  end
  
  mount Admin::Api::V1::Agents::Routes
  mount Admin::Api::V1::Roles::Routes
end
