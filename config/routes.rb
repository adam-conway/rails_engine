Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :merchants, only: [:index, :show] do
        get '/items/', to: 'merchants/items#index'
        get '/invoices/', to: 'merchants/invoices#index'
      end

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :customers, only: [:index, :show]

      namespace :invoices do
        get '/find/', to: 'search#show'
        get '/find_all/', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :invoices, only: [:index, :show] do
        get '/transactions/', to: 'invoices/transactions#index'
        get '/invoice_items/', to: 'invoices/invoice_items#index'
        get '/items/', to: 'invoices/items#index'
        get '/customer/', to: 'invoices/customer#index'
        get '/merchant/', to: 'invoices/merchant#index'
      end

      namespace :items do
        get '/find/', to: 'search#show'
        get '/find_all/', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :items, only: [:index, :show]

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :transactions, only: [:index, :show] do
        get '/invoice/', to: 'transactions/invoice#show'
      end
    end
  end
end
