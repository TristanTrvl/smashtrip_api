Rails.application.routes.draw do
  resources :users, param: :_id do
    resource :house
    resources :housing_adverts, param: :_id
  end
  resources :housing_adverts, param: :_id, only: :index
  resources :conveniences, param: :_id
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end