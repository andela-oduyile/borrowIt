Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :requests
      get 'user/:id', to: 'users#show'
    end
  end
end
