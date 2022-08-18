class Admin::Api::V1::Agents::Routes < Grape::API
  formatter :json, SuccessFormatter
  error_formatter :json, ErrorFormatter

  mount Admin::Api::V1::Agents::Resources::Agent
end
