Rails.application.routes.draw do
  resources :rooms, only: [:index, :create, :show] do
    resources :messages, only: [:create, :index]
  end
  
  mount ActionCable.server => '/cable'
end
