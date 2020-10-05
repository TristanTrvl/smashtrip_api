Rails.application.routes.draw do
  resources :users, param: :id do
    resource :house
    resources :housing_adverts, param: :id 
  end
  resources :conveniences, param: :id
  get "/housing_adverts", to: "housing_adverts#index_all"
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end