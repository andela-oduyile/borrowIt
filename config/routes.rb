Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :requests do
        collection do
          get :leased
        end

        member do
          put :accept
        end
      end

      resources :users, only: :show do
        collection do
          get :me
        end
      end
    end
  end
  root 'welcome#index'
  get '/auth/:provider/callback', to: 'sessions#create', as: :sign_in_callback
end
