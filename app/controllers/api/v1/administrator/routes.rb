class Api::V1::Administrator::Routes < Grape::API
    formatter :json, SuccessFormatter
    error_formatter :json, ErrorFormatter

    mount Api::V1::Administrator::Resources::Administrator
end