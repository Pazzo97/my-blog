Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
    end
  end

  resources :posts, only: [:new, :create, :update, :destroy] do
    resources :comments
    resources :likes
  end

    namespace :api do 
    namespace :v1 do
      resources :users, only: %i[index] do
        resources :posts, only: %i[index show] do
          resources :comments, only: %i[new create] do
          end
        end
      end
    end
  end

  # default_url_options :host => "example.com"

  # if Rails.env.development?
  #   mount LetterOpenerWeb::Engine, at: "/letter_opener"
  # end
end
