Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
    end
  end

  resources :posts do
    resources :comments, only: [:new, :create]
    resources :likes, only: [:create]
  end

  # default_url_options :host => "example.com"

  # if Rails.env.development?
  #   mount LetterOpenerWeb::Engine, at: "/letter_opener"
  # end
end
