Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  get '/health', to: proc { [200, {}, ['ok']] }

  get '/debug/routes', to: 'debug#routes'

  get '/test_broadcast/:room_id', to: 'application#test_broadcast'

  resources :rooms, only: [:index, :create, :show] do
    resources :messages, only: [:create, :index]
  end
end
