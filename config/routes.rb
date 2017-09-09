Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :requests
      get 'user/:id', to: 'users#show'
    end
  end
  get '/auth/:provider/callback', to: 'sessions#create', as: :sign_in_callback
end
