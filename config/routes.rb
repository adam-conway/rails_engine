Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/most_items/', to: 'most_items#show'
        get '/revenue/', to: 'total_revenue#show'
        get '/most_revenue/', to: 'most_revenue#index'
      end

      resources :merchants, only: [:index, :show] do
        get '/items/', to: 'merchants/items#index'
        get '/invoices/', to: 'merchants/invoices#index'
        get '/revenue/', to: 'merchants/revenue#show'
        get '/customers_with_pending_invoices', to: 'merchants/customers#index'
        get '/favorite_customer', to: 'merchants/customers#show'
      end

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :invoices do
        get '/find/', to: 'search#show'
        get '/find_all/', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :items do
        get '/find/', to: 'search#show'
        get '/find_all/', to: 'search#index'
        get '/random', to: 'random#show'
        get '/most_revenue/', to: 'revenue#index'
      end

      resources :items, only: [:index, :show] do
        get '/merchant/', to: 'items/merchant#show'
        get '/invoice_items/', to: 'items/invoice_items#index'
      end

      namespace :invoice_items do
        get '/find/', to: 'search#show'
        get '/find_all/', to: 'search#index'
        get '/random', to: 'random#show'
      end

      resources :invoices, only: [:index, :show] do
        get '/transactions/', to: 'invoices/transactions#index'
        get '/invoice_items/', to: 'invoices/invoice_items#index'
        get '/items/', to: 'invoices/items#index'
        get '/customer/', to: 'invoices/customer#show'
        get '/merchant/', to: 'invoices/merchant#show'
      end

      resources :invoice_items, only: [:index, :show] do
        get '/item/', to: 'invoice_items/item#show'
        get '/invoice/', to: 'invoice_items/invoice#show'
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :transactions, only: [:index, :show] do
        get '/invoice/', to: 'transactions/invoice#show'
      end

      resources :customers, only: [:index, :show] do
        get '/invoices/', to: 'customers/invoices#index'
        get '/transactions/', to: 'customers/transactions#index'
        get '/favorite_merchant/', to: 'customers/favorite_merchant#show'
      end
    end
  end
end
