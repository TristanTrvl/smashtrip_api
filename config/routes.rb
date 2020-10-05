Rails.application.routes.draw do
  resources :users, param: :_id do
    resource :house
    resources :housing_adverts, param: :_id 
  end
  resources :conveniences, param: :_id
  get "/housing_adverts", to: "housing_adverts#index_all"
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end