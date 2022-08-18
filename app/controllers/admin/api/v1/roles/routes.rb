class Admin::Api::V1::Roles::Routes < Grape::API
    formatter :json, SuccessFormatter
    error_formatter :json, ErrorFormatter
  
    mount Admin::Api::V1::Roles::Resources::Role
  end
  