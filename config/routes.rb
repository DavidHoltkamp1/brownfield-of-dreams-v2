Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only: %i[show index]
      resources :videos, only: [:show]
    end
  end

  root 'welcome#index'
  get 'tags/:tag', to: 'welcome#index', as: :tag
  get '/register', to: 'users#new'
  get '/activation/:user_id', to: 'activation#create'
  get '/invite', to: 'invites#new'
  post '/invite', to: 'invites#create'

  namespace :admin do
    get '/dashboard', to: 'dashboard#show'
    resources :tutorials, only: %i[create edit update destroy new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: %i[edit update destroy]

    namespace :api do
      namespace :v1 do
        put 'tutorial_sequencer/:tutorial_id', to: 'tutorial_sequencer#update'
      end
    end
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'
  get '/about', to: 'about#show'
  get '/get_started', to: 'get_started#show'

  get '/friendships/:login', to: 'friendships#create'

  # Is this being used?
  get '/video', to: 'video#show'

  resources :users, only: %i[new create update edit]

  resources :tutorials, only: %i[show index] do
    resources :videos, only: %i[show index]
  end

  get '/auth/:provider/callback', to: 'sessions#update'

  resources :user_videos, only: %i[create destroy]
end
