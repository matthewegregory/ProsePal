Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [:index, :show] do
    resources :posts do
      get 'edit', on: :member
      resources :likes, only: [:create]
      resources :comments
    end
  end

  get 'my_posts', to: 'posts#my_posts', as: 'my_posts'
  get '/users/:user_id/posts/:id/custom_edit', to: 'posts#edit', as: 'custom_edit_user_post'

  root "application#home"
end
