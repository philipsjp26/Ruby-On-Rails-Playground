class Api::V1::Web::Routes < Grape::API
    formatter :json, SuccessFormatter
    error_formatter :json, ErrorFormatter

    mount Api::V1::Web::Resources::Users
    mount Api::V1::Web::Resources::Wallets
end