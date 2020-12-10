Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :clocked_times, only: %i[create index]
      end

      resources :friend_relationships, only: [:create] do
        member do
          post :confirm
        end
      end
    end
  end
end
