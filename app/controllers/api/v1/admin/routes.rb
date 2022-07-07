class Api::V1::Admin::Routes < Grape::API
    formatter :json, SuccessFormatter
    error_formatter :json, ErrorFormatter

    mount Api::V1::Admin::Resources::Users
    mount Api::V1::Admin::Resources::Roles
    mount Api::V1::Admin::Resources::Menus
end