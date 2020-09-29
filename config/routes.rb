Rails.application.routes.draw do
  resources :users, param: :_id do
    resource :house
  end
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end