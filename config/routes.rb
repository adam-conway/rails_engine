Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :invoices do
        get '/find/', to: 'search#show'
        get '/find_all/', to: 'search#index'
      end

      resources :invoices, only: [:index, :show]

      resources :merchants, only: [:index, :show] do
        get '/items/', to: 'merchants/items#index'
        get '/invoices/', to: 'merchants/invoices#index'
      end
    end
  end
end
