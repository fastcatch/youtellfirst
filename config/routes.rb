Youtellfirst::Application.routes.draw do

  resource :home, only: [:show]

  uuid_regex = /([a-z0-9]){8}-([a-z0-9]){4}-([a-z0-9]){4}-([a-z0-9]){4}-([a-z0-9]){12}/
  resources :answers, only: [:show, :edit, :update], :constraints => {:id => uuid_regex}

  authenticated :user do
    root :to => 'questions#index'
    resources :questions, only: [:index, :show, :new, :create, :destroy]
    resources :answers, only: [:index]
  end

  devise_for :users
  root :to => "homes#show"
end
