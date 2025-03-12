class Api::V1::Web::Resources::Wallets < Grape::API
  helpers Api::Helpers::AuthHelper
  before do
    authenticate!
  end

  resources :wallets do
    desc "Get current wallet balance"
    params do
      requires :entity_id, type: Integer, desc: 'Describe user id'
      requires :owner_type, type: String, values: ["user", "team", "stock"]
    end
    get "/:entity_id" do

      wallet = Wallet.find_by(user_id: params.entity_id, owner_type: params.owner_type)
      error!("wallet doesn't exists", 404) unless wallet.present?
      present :wallet, wallet, with: Api::V1::Web::Entities::Wallets
    end

    desc 'Credit wallet'
    params do
      requires :amount, type: BigDecimal, desc: 'Amount to credit'
      requires :owner_type, type: String, values: ["user", "team", "stock"]
    end
    post '/:entity_id/credit' do
      wallet = Wallet.find_by(user_id: params[:entity_id], owner_type: params[:owner_type])
      error!('Wallet not found', 404) unless wallet

      wallet.update!(balance: wallet.balance + params[:amount])
      env['api.response.message'] = "Wallet credited successfully"

      present :wallet, wallet, with: Api::V1::Web::Entities::Wallets
    end

    desc 'Debit wallet'
    params do
      requires :amount, type: BigDecimal, desc: 'Amount to debit'
      requires :owner_type, type: String, values: ["user", "team", "stock"]
    end
    post '/:entity_id/debit' do
      wallet = Wallet.find_by(user_id: params[:entity_id], owner_type: params[:owner_type])
      error!('Wallet not found', 404) unless wallet
      error!('Insufficient balance', 400) if wallet.balance < params[:amount]

      wallet.update!(balance: wallet.balance - params[:amount])
      env['api.response.message'] = "Wallet debited successfully"

      present :wallet, wallet, with: Api::V1::Web::Entities::Wallets
    end
  end
end
