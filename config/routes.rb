Rails.application.routes.draw do
  devise_for :users#, controllers: { sessions: 'users/sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # delete '/users/sign_out', to: 'application#sign_out_user', as: :destroy_user_session
  # devise_scope :user do
  #   delete '/users/sign_out', to: 'devise/sessions#destroy'
  # end

  delete '/users/sign_out', to: 'users#sign_out_user', as: :sign_out_user

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [:index, :show]
  resources :posts do
    get 'edit', on: :member
    post '/like', to: 'likes#create', as: :like_post
    resources :comments
  end
  resources :tags

  get 'my_posts', to: 'posts#my_posts', as: 'my_posts'
  get '/users/:user_id/posts/:id/custom_edit', to: 'posts#edit', as: 'custom_edit_user_post'
  get '/search', to: 'search#index', as: 'search'

  root "application#home"
end
