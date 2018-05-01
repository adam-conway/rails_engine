Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
      end
      resources :merchants, only: [:index, :show]
    end
  end

  # get "/api/v1/merchants/find", to: 'search#find'
end
