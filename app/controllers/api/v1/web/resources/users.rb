# frozen_string_literal: true

module Api
  module V1
    module Web
      module Resources
        class Users < Grape::API
          helpers Api::Helpers::AuthHelper

          resource :users do
            desc 'List users'
            params do
              optional :q, type: String
              optional :start_date, type: Date
              optional :end_date, type: Date
            end
            get '/' do
              data = paginate User.all
              present :users, data, with: Api::V1::Admin::Entities::Users
            end

            desc 'Login authentication'
            params do
              requires :email, type: String
              requires :password, type: String
            end
            post '/login' do
              user = User.find_by(email: params.email)
              error!("user not found", env['api.response.code'] = 404) if !user.present? || !user&.authenticate(params.password)
              token = encode_token({ user_id: user.id, exp: (Time.now + 24.hours).to_i })
              env['api.response.message'] = "Success login"
              present :users, token
            end

            desc "Authenticate"
            get "/me" do
              authenticate!
              present :user, current_user.id
            end
          end
        end
      end
    end
  end
end
