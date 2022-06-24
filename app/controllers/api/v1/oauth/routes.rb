class Api::V1::Oauth::Routes < Grape::API
    formatter :json, SuccessFormatter
    error_formatter :json, ErrorFormatter

    mount Api::V1::Oauth::Resources::Oauth
end